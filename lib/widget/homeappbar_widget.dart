import 'package:flutter/material.dart';
import '../utils/screen_util.dart';

//首页显示AppBar
class HomeAppBarWidget extends StatelessWidget {

  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final double height;
  final EdgeInsets padding; //appBar的padding值，用于设置搜索框的显示边距
  final double fontSize; //搜索框中文字的大小
  final Function() onTap;
  
  HomeAppBarWidget({this.title,
                    this.backgroundColor=Colors.pinkAccent,
                    this.titleColor,
                    this.height=70,
                    this.padding,
                    this.fontSize=16,
                    this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor,
      padding: padding,
      child: InkWell(
        child: _searchWidget(),
        onTap: (){
          if(onTap != null){
            onTap();
          }
        },
      ),
    );
  }

  Widget _searchWidget(){
    return Container(
      padding: EdgeInsets.all(ScreenUtils.width(5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(5)
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search,color:Colors.black12,size:ScreenUtils.width(35)),
          SizedBox(width: ScreenUtils.width(5),),
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: fontSize
            ),
          )
        ],
      ),
    );
  }
}