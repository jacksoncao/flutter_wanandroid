import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/pages/wechat_articles_page.dart';
import 'package:flutter_wananzhuo/tabs/main_tab.dart';
import '../pages/detail_page.dart';
import '../pages/knowledge_articles_page.dart';
import '../pages/register_page.dart';
import '../pages/login_page.dart';
import '../pages/wap_list_page.dart';
import '../pages/wechat_page.dart';
import '../pages/about_page.dart';
import '../pages/collection_page.dart';
import '../pages/todo_page.dart';
import '../pages/todo_edit_page.dart';
import '../pages/test_page.dart';
import '../pages/search_page.dart';
import '../pages/open_source_page.dart';

//全局路由配置
final Map<String,dynamic> routes = {
  "/":(context)=>MainTabs(),
  "/detail_page":(context,{arguments})=>DetailPage(arguments:arguments),
  "/knowledge_articles_page":(context,{arguments})=>KnowledgeArticlesPage(arguments: arguments,),
  "/register_page":(context)=>RegisterPage(),
  "/login_page":(context)=>LoginPage(),
  "/wap_list_page":(context)=>WapListPage(),
  "/wechat_list_page":(context)=>WeChatListPage(),
  "/wechat_articles_page":(context,{arguments})=>WeChatArticlesPage(arguments:arguments),
  "/about_page":(context)=>AboutPage(),
  "/collection_page":(context)=>CollectionPage(),
  "/todo_page":(context)=>TodoPage(),
  "/todo_edit_page":(context,{arguments})=>TodoEditPage(arguments:arguments),
  "/test_page":(context)=>TestPage(),
  "/search_page":(context)=>SearchPage(),
  "/open_source_page":(context)=>OpenSourceListPage()
};

//接管Flutter生成路由的方法，我们可以增加参数，实现命名路由动态传参
Route onGenerateRoute(RouteSettings settings){
  String routeName = settings.name ;
  print("路由名称:======>$routeName");
  final Function pageContentBuilder = routes[routeName];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      Route route = MaterialPageRoute(
        builder:(context) => pageContentBuilder(context,arguments:settings.arguments)
      );
      return route;
    }else{
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
  return null;
}