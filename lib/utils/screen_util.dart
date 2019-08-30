import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils{

  static init(BuildContext context){
    //初始化设计稿的宽高：480 * 800
    ScreenUtil.instance = ScreenUtil(width:480.0,height:800.0)..init(context);
  }

  //屏幕实际的像素宽度
  static double get screenWidth => ScreenUtil.screenWidth;

  //屏幕实际的像素高度
  static double get screenHeight => ScreenUtil.screenHeight;

  //屏幕的逻辑宽度
  static double get screenWidthDp => ScreenUtil.screenWidthDp;

  //屏幕的逻辑高度
  static double get screenHeightDp => ScreenUtil.screenHeightDp;

  //将设计稿中的元素宽度转化成屏幕中的宽
  static width(double width) => ScreenUtil.instance.setWidth(width);

  //将设计稿中的元素的高度转换成屏幕中的高
  static height(double height) => ScreenUtil.instance.setHeight(height);

  //状态栏的高度  逻辑高度
  static statusBarHeight() =>ScreenUtil.statusBarHeight;
  
}