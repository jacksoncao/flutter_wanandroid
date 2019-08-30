import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import '../utils/screen_util.dart';

//搜索AppBar
class SearchAppBarWidget extends StatefulWidget {

  final Function(String value) onTap;  //点击搜索按钮
  final double height; //AppBar的高度
  final EdgeInsets padding; //AppBar的内边距
  final double textFieldPadding; //输入框的内部边距
  final double fontSize;
  final Color titleColor;
  final Color backgroundColor;
  final void Function(String value,int length) onChanged; //输入框内容变化时调用
  final void Function(SearchController controller) onSearchBarCreated;

  SearchAppBarWidget({this.onTap,
                      this.height,
                      this.padding,
                      this.textFieldPadding=10,
                      this.fontSize=15,
                      this.titleColor,
                      this.backgroundColor=Colors.pinkAccent,
                      this.onChanged,
                      this.onSearchBarCreated});

  _SearchAppBarWidgetState createState() => _SearchAppBarWidgetState();
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> with SearchController{

  TextEditingController _controller = TextEditingController();
  bool disposed = false;

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
    disposed = true;
  }

  @override
  void setSearchValue(String value){
    if(_controller != null && !disposed){
      setState(() {
        _controller.text = value;
        _controller.selection = TextSelection.collapsed(offset:value.length);
      });
    }
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
        padding: EdgeInsets.all(ScreenUtils.width(widget.textFieldPadding)),
        child: TextField(
          decoration: null, //去掉TextField的
          controller: _controller,
          maxLines: 1,
          onChanged: (value){
            if(widget.onChanged != null){
              widget.onChanged(value,value.length);
            }
          },
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.titleColor
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _widget =  Container(
      height: widget.height,
      padding: widget.padding,
      color: widget.backgroundColor,
      child: Row(
        children: <Widget>[
          _backWidget(),
          _inputWidget(),
          _searchButton()
        ],
      ),
    );
    if(widget.onSearchBarCreated != null){
      widget.onSearchBarCreated(this);
    }
    return _widget;
  }
}

abstract class SearchController{

  void setSearchValue(String value);

}