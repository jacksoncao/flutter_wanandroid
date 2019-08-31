import 'package:flutter/material.dart';
import 'todo_complete_page.dart';
import 'todo_uncomplete_page.dart';
import 'package:flutter_wananzhuo/utils/screen_util.dart';

/*
 * 使用另一种方式实现tab页面的切换
 * 
 * 同时解决：页面状态保存 + 切换只有初次会执行build方法 + 懒加载
 */  
class TodoPage extends StatefulWidget {
  TodoPage({Key key}) : super(key: key);

  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  int _currentIndex = 0;

  static final titles = ["待办事项","完成事项"];

  static Widget getItemTitle(String title){
    return Text(
      title,
      style: TextStyle(
        fontSize: 14
      ),
    );
  }

  static List<Widget> getItemIcons(String icon,String activeIcon){
    return [
      Image.asset(icon,width: ScreenUtils.width(35),
            height:ScreenUtils.width(40)),
      Image.asset(activeIcon,width: ScreenUtils.width(35),
            height:ScreenUtils.width(40))
    ];
  }

  static final icons = [
    getItemIcons("images/untodo.png", "images/untodo_red.png"),
    getItemIcons("images/todo.png", "images/todo_red.png")
  ];

  final items = [
    BottomNavigationBarItem(
      title: getItemTitle(titles[0]),
      icon: icons[0][0],
      activeIcon: icons[0][1]
    ),
    BottomNavigationBarItem(
      title: getItemTitle(titles[1]),
      icon: icons[1][0],
      activeIcon: icons[1][1]
    )
  ];

  final pages = [
    TodoUnCompletePage(),
    Container()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            //第一次切换到对应的tab，才替换为真正要加载的页面，这样可以实现懒加载的问题
            if(index == 1 && pages[1] is Container) pages[1] = TodoCompletePage();
            _currentIndex = index; 
          });
        },
      ),
      //使用IndexedStack默认就会保存状态，只是在第一次初始化会执行build，后面的切换不会再执行build了
      body: IndexedStack(
        children: pages,
        index: _currentIndex,
      )
    );
  }
}