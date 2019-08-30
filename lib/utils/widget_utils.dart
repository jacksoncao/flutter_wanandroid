import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/screen_util.dart';
import '../widget/homeappbar_widget.dart';


//通用页面的Appbar，统一采用相同的字体，颜色样式
Widget commonAppBar(String title,{bool centerTitle = true,List<Widget> actions}){
  return AppBar(
    backgroundColor: Colors.pinkAccent,
    centerTitle: centerTitle,
    title: Text(
      "$title",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20
      ),
    ),
    actions: actions,
  );
}

//带Tab的AppBar
Widget tabAppBar(String title,List<Tab> tabs,{bool centerTitle = true}){
  return AppBar(
    backgroundColor: Colors.pinkAccent,
    centerTitle: centerTitle,
    title: Text(
      "$title",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20
      ),
    ),
    bottom: TabBar(
      labelColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
      ),
      unselectedLabelColor: Colors.black38,
      labelStyle: TextStyle(
        fontSize: 16,
      ),
      tabs: tabs,
    ),
  );
}

//首页样式AppBar
Widget homeAppBar(BuildContext context,String title){
  return HomeAppBarWidget(
    title: title,
    titleColor: Colors.grey,
    fontSize: 14,
    height: ScreenUtils.width(110),
    padding: EdgeInsets.fromLTRB(
        ScreenUtils.width(30),
        ScreenUtils.width(13)+ScreenUtils.statusBarHeight(),
        ScreenUtils.width(30),
        ScreenUtils.width(13)),
    onTap: () => Navigator.of(context).pushNamed("/search_page"),
  );
}


//显示toast
void showToast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    textColor: Colors.white,
    backgroundColor: Colors.grey,
    fontSize: 16
  );
}