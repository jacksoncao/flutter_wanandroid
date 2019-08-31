import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import '../utils/screen_util.dart';

//搜索AppBar
class SearchAppBarWidget extends StatefulWidget {

  final String searchText; //搜索词
  final double height; //AppBar的高度
  final double textFieldPadding; //输入框的内部边距，内容文字距离输入框的四周的边距
  final double fontSize; //输入框的内容文字的大小
  final Color textColor; //输入框内容文字的颜色
  final Color backgroundColor; //AppBar的背景色
  final Function(String value) onTap;  //点击搜索按钮
  final void Function(String value) onValueChanged; //输入框内容变化时调用
  final void Function(SearchTextChangeNotifier notifier) onReceiveNotifier; 

  SearchAppBarWidget({this.searchText,
                      this.height,
                      this.textFieldPadding=10,
                      this.fontSize=15,
                      this.textColor,
                      this.backgroundColor=Colors.pinkAccent,
                      this.onTap,
                      this.onValueChanged,
                      this.onReceiveNotifier});

  _SearchAppBarWidgetState createState() => _SearchAppBarWidgetState();
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> with SearchTextChangeNotifier{

  TextEditingController _controller = TextEditingController();
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchText;
    if(widget.onReceiveNotifier != null){
      widget.onReceiveNotifier(this);
    }
  }

  @override
  void changeText(String searchText){
    setState(() {
       _controller.text = searchText;
       _controller.selection = TextSelection.collapsed(offset:searchText.length);
    });
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
    disposed = true;
  }

  //搜索按钮
  Widget _searchButton(){
    return Container(
      width: ScreenUtils.width(70),
      margin: EdgeInsets.all(ScreenUtils.width(15)),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            child: Text("搜索",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
          ),
          onTap: (){
            if(_controller.text == null || _controller.text.length == 0){
              showToast("输入内容为空");
              return;
            }
            if(widget.onTap != null){
              widget.onTap(_controller.text);
            }
          },
        ),
      ),
    );
  }

  //返回按钮
  Widget _backWidget(){
    return IconButton(
      icon: Icon(Icons.arrow_back,size: ScreenUtils.width(35),color: Colors.white,),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  //输入框
  Widget _inputWidget(){
    return Expanded(
      flex: 1,
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top:ScreenUtils.width(10),bottom:ScreenUtils.width(10)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
        ),
        alignment: Alignment.center,
        child: TextField(
          decoration: InputDecoration(
            hintText: "输入搜索词搜搜试试吧！",
            hintStyle: TextStyle(color: Colors.black12),
            border: InputBorder.none,  //输入框不需要边框
            contentPadding: EdgeInsets.all(ScreenUtils.width(widget.textFieldPadding)),
          ), 
          controller: _controller,
          maxLines: 1,
          onChanged: (value){
            if(widget.onValueChanged != null){
              widget.onValueChanged(value);
            }
          },
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(top:ScreenUtils.statusBarHeight), //顶部偏移状态栏高度
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          _backWidget(), //返回按钮组件
          _inputWidget(),  //输入框组件
          _searchButton()  //搜索按钮组件
        ],
      ),
    );
  }
}

abstract class SearchTextChangeNotifier{

  void changeText(String searchText);

}