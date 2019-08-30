import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/base_result_model.dart';
import '../model/base_page_model.dart';
import '../utils/widget_utils.dart';

//将下拉刷新组件进行封装，在项目中使用更加简单
class RefreshWidget<T> extends StatefulWidget {

  final Widget child;
  final LoadMore<T> onLoadMore; //加载更多
  final RefreshFooter footer;
  final Function(List<T> datas) onResultData; //加载一页数据成功，将数据返给外界
  final int initialPageIndex; //默认起始页码，加载更多总是从下一页开始请求

  RefreshWidget({@required this.child,
                 @required this.onLoadMore,
                 this.footer,
                 @required this.onResultData,
                 this.initialPageIndex=0});

  _RefreshWidgetState<T> createState() => _RefreshWidgetState();
}

//加载更多方法定义
typedef LoadMore<T> = Future<BaseResultModel<BasePageModel<T>>> Function(int nextPageIndex);
typedef RefreshFooter = Footer Function();

class _RefreshWidgetState<T> extends State<RefreshWidget<T>>{

  final EasyRefreshController _controller = EasyRefreshController();

  int _nextPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _nextPageIndex = widget.initialPageIndex+1;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: EasyRefresh(
         child: widget.child,
         footer: widget.footer == null ? BallPulseFooter() : widget.footer(),
         enableControlFinishLoad: true,
         controller: _controller,
         onLoad: () async{
           BaseResultModel<BasePageModel<T>> resultData = await widget.onLoadMore(_nextPageIndex);
           LoadResult result = processLoadResult(resultData);
           _controller.finishLoad(success: result.success,noMore: result.noMore);
         },
       ),
    );
  }

  LoadResult processLoadResult(BaseResultModel<BasePageModel<T>> resultModel){
    LoadResult result;
    if(resultModel.resultCode == BaseResultModel.STATE_OK){
      _nextPageIndex++;
      widget.onResultData(resultModel.data.datas);
      result = LoadResult(success: true,noMore: resultModel.data.over);
    }else if(resultModel.resultCode == BaseResultModel.NO_DATA){
      showToast("没有更多数据啦");
      result = LoadResult(success: true,noMore: true);
    }else{
      showToast("${resultModel.errorMsg}");
      result = LoadResult(success: false,noMore: false);
    }
    return result;
  }

}

//加载结果
class LoadResult{
  final bool success;  //本次加载是否成功
  final bool noMore; //是否没有更多
  LoadResult({this.success,this.noMore});
}