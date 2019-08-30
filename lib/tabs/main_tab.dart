import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/project_page.dart';
import '../pages/navigation_page.dart';
import '../pages/mine_page.dart';
import '../pages/knowledge_page.dart';


class MainTabs extends StatefulWidget {
  MainTabs({Key key}) : super(key: key);

  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {

  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("首页")
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      title: Text("项目")
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      title: Text("知识体系")
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.navigation),
      title: Text("导航")
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("我的")
    )
  ];

  final _pages = [
    HomePage(),
    ProjectPage(),
    KnowledgePage(),
    NavigationPage(),
    MimePage()
  ];

  int _currentIndex = 0;

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();  //避免内存泄漏
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        fixedColor: Colors.red,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(), //禁止页面的滑动，只能通过底部来进行切换
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
    );
  }

  _onTap(index){
    _controller.jumpToPage(index);
  }

  _onPageChanged(index){
    setState(() {
       _currentIndex = index;
    });
  }

}