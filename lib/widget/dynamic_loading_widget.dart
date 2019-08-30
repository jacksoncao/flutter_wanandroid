import 'package:flutter/material.dart';
import '../model/base_result_model.dart';
import '../utils/screen_util.dart';

//动态加载内容Widget，包括页面的所有状态：加载中，加载成功，加载失败，没有数据
class DynamicLoadingWidget<T> extends StatefulWidget {

  final Widget Function() loadingWidget;  //正在加载组件视图通过这个方法设置
  final Widget Function() noDataWidget;  //没有数据页面组件通过这个方法设置
  final WidgetLoadedBuilder<T> loadedWidget;  //加载成功页面组件通过这个方法设置
  final WidgetFailedBuilder failedWidget;  //加载失败页面组件通过这个方法设置
  final Function(T data) receiveData;  //加载成功后，组件会回调这个方法，将数据提供给外界
  final AsyncLoad<T> asyncLoad; //加载数据方法需要返回Future<BaseModel<T>>类型值
  final StateController controller; //状态控制器
  final PreBuilder preRefreshState; //页面加载完成后，在每次重新build时，外界可以修改页面状态

  DynamicLoadingWidget({this.loadingWidget,
                        @required this.loadedWidget,
                        this.noDataWidget,
                        this.failedWidget,
                        this.receiveData,
                        this.controller,
                        this.preRefreshState,
                        @required this.asyncLoad});

  _DynamicLoadingWidgetState<T> createState() => _DynamicLoadingWidgetState<T>();

}

typedef WidgetLoadedBuilder<T> = Widget Function(T data);
typedef WidgetFailedBuilder = Widget Function(StateController controller);
typedef AsyncLoad<T> = Future<BaseResultModel<T>> Function();
typedef PreBuilder = void Function(StateController controller);

class _DynamicLoadingWidgetState<T> extends State<DynamicLoadingWidget<T>> with StateChangeCallback{

  bool _isLoading = false;

  bool _isDetached = false;

  BaseResultModel<T> _model;

  StateController controller; //状态控制器

  LoadState _currentState;

  @override
  void initState() {
    super.initState();
    controller = widget.controller == null ? StateController() : widget.controller;
    controller.stateChangeCallback(this);
  }

  @override
  void dispose() {
    super.dispose();
    _isDetached = true;
  }

  @override
  void initialState(LoadState state) {
    _currentState = state;
  }

  @override
  void changeState(LoadState state){
    if(!_isDetached){ //避免在页面已经退出，数据回来后进行build操作
      setState(() {
        _currentState = state; 
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if(widget.preRefreshState != null && (_currentState == LoadState.NO_DATA 
        || _currentState == LoadState.PAGE_INIT)){
        widget.preRefreshState(controller);
    }
    if(_currentState == LoadState.LOADING){ //页面处于加载中状态
      if(!_isLoading){  //如果已经开始请求数据了，则不再请求
        _isLoading = true;
        _asyncLoading();  //请求数据
      }
      return widget.loadingWidget == null ? _defaultLoadingWidget() 
                : widget.loadingWidget();
    }else if(_currentState == LoadState.PAGE_INIT){
      _isLoading = false;
      return widget.loadedWidget(_model.data);
    }else if(_currentState == LoadState.NO_DATA){
      _isLoading = false;
      return widget.noDataWidget == null ? _defaultNoDataWidget() 
                : widget.noDataWidget();
    }else{
      _isLoading = false;
      return widget.failedWidget == null ? LoadFailWidget(controller:controller) 
                : widget.failedWidget(controller);
    }
  }

  LoadState getLoadState(BaseResultModel model){
    _model = model;
    switch(model.resultCode){
      case BaseResultModel.STATE_OK:
        return LoadState.SUCCEED;
      case BaseResultModel.STATE_ERROR:
        return LoadState.FAILED;
      case BaseResultModel.NO_DATA:
        return LoadState.NO_DATA;
      case BaseResultModel.INVALID_LOGIN:
        return LoadState.INVALID_LOGIN;
      default:
        return LoadState.FAILED;
    }
  }

  _asyncLoading(){
    widget.asyncLoad().then((model){
      LoadState currentState = getLoadState(model);
      if(currentState == LoadState.SUCCEED){
        currentState = LoadState.PAGE_INIT;
        if(widget.receiveData != null){
          widget.receiveData(_model.data);
        }
      }else if(currentState == LoadState.INVALID_LOGIN){
        Navigator.of(context).pushNamed("/login_page");
        currentState = LoadState.FAILED;
      }
      changeState(currentState);
    })
    .catchError((e,StackTrace trace){
      print("发生异常了====>${trace.toString()}");
      _model = null;
      changeState(LoadState.FAILED);
    });
  }

  //默认加载中组件
  Widget _defaultLoadingWidget(){
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  //默认没有数据组件
  Widget _defaultNoDataWidget(){
    return Container(
      alignment: Alignment.center,
       child: Text("没有数据"),
    );
  }

}

//加载失败
class LoadFailWidget extends StatefulWidget {

  final StateController controller;

  const LoadFailWidget({this.controller});

  _LoadFailWidgetState createState() => _LoadFailWidgetState();
}

class _LoadFailWidgetState extends State<LoadFailWidget> {

  Widget _reloadWidget(){
    return OutlineButton(
      highlightedBorderColor:Colors.pinkAccent,
      borderSide: BorderSide(color: Colors.blue),
      child: Text("点击重试",style: TextStyle(color: Colors.blue),),
        onPressed: (){
          widget.controller?.loading();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/net_error.png",
            width:ScreenUtils.width(100),
            height:ScreenUtils.height(100)
          ),
          _reloadWidget()
        ],
      ),
    );
  }
}

abstract class StateChangeCallback{

  void initialState(LoadState state);

  void changeState(LoadState state);

}

//页面状态控制器，外部和内部都可以通过这个状态控制器控制页面状态
class StateController{

  final LoadState initializeState;
  StateChangeCallback statechangeCallback;

  StateController({this.initializeState = LoadState.LOADING})
    :assert(initializeState != null);

  void stateChangeCallback(callback){
      statechangeCallback = callback; 
      statechangeCallback.initialState(initializeState);
    } 

  void loading(){
    if(statechangeCallback != null){
      statechangeCallback.changeState(LoadState.LOADING);
    }
  }

  void failed(){
    if(statechangeCallback != null){
      statechangeCallback.changeState(LoadState.FAILED);
    }
  } 

  void noData(){
    if(statechangeCallback != null){
      statechangeCallback.changeState(LoadState.NO_DATA);
    }
  }

  void loaded(){
    if(statechangeCallback != null){
      statechangeCallback.changeState(LoadState.PAGE_INIT);
    }
  }

}

//网络请求状态定义
enum LoadState{

  LOADING,  //加载中

  FAILED,  //加载失败

  NO_DATA,  //没有数据

  SUCCEED,  //加载成功

  PAGE_INIT, //根据数据初始化页面

  INVALID_LOGIN, //需要重新登录

}


