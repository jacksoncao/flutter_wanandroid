import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/widget_utils.dart';
import 'collection_articles_page.dart';
import 'collection_wap_page.dart';

//我的收藏页面，两个tab：1.收藏文章   2.收藏网页
class CollectionPage extends StatelessWidget {
  
  final tabs = [
    Tab(text: "文章",),
    Tab(text: "网站",)
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: tabAppBar("我的收藏", tabs),
        body: TabBarView(
          children: <Widget>[
            CollectionArticlesPage(),
            CollectionWapPage()
          ],
        ),
      ),
    );
  }
}