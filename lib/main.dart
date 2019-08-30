import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wananzhuo/provider/home_provider.dart';
import 'package:flutter_wananzhuo/provider/search_provider.dart';
import 'package:flutter_wananzhuo/provider/todo_provider.dart';
import 'provider/knowledge_provider.dart';
import 'provider/project_provider.dart';
import 'utils/net_utils.dart';
import 'package:provider/provider.dart';
import 'provider/navigation_provider.dart';
import 'route/routes.dart';
import 'provider/user_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main(){
  //固定app的方向为竖直方向
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
  );
  //初始化网络请求库dio
  NetUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider(),),
        ChangeNotifierProvider.value(value: NavigationProvider(),),
        ChangeNotifierProvider.value(value: ProjectProvider(),),
        ChangeNotifierProvider.value(value: KnowledgeProvider(),),
        ChangeNotifierProvider.value(value: UserProvider(),),
        ChangeNotifierProvider.value(value: TodoProvider(),),
        ChangeNotifierProvider.value(value: SearchProvider(),)
      ],
      child: MaterialApp(
        title: "玩安卓",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        //国际化支持
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US'),
        ],
        //配置起始页面路由
        initialRoute: "/",
        onGenerateRoute: onGenerateRoute,
      )
    );
  }
}