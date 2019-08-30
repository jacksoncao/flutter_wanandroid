import 'package:flutter/material.dart';
import '../model/article/article_page_model.dart';
import '../widget/article_item_widget.dart';
import '../widget/dynamic_loading_widget.dart';
import '../widget/refresh_widget.dart';
import '../utils/widget_utils.dart';
import '../model/wechat/wechat_model.dart';
import '../dao/wechat_dao.dart';
import '../model/common/common_model.dart';

//公众号文章列表页面
class WeChatArticlesPage extends StatefulWidget {

  final Object arguments;

  WeChatArticlesPage({this.arguments});

  _WeChatArticlesPageState createState() => _WeChatArticlesPageState();
}

class _WeChatArticlesPageState extends State<WeChatArticlesPage> {

  WeChatModel model;

  //微信公众号文章列表
  List<CommonModel> _articleList = [];

  addArticleList(List<CommonModel> articles){
    if(articles != null && articles.length > 0){
      setState(() {
        _articleList.addAll(articles);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    model = widget.arguments as WeChatModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("${model.name}",centerTitle: false),
      body: Container(
        color: Colors.black12,
        child: DynamicLoadingWidget<ArticlePageModel>(
          asyncLoad: () => WeChatDao.getWeChatArticleList(model.id, 1),
          loadedWidget: (data){
            return RefreshWidget<CommonModel>(
              child: ListView.builder(
                itemCount: _articleList.length,
                itemBuilder: (context,index) => ArticleItemWidget(data:_articleList[index]),
              ),
              onLoadMore: (index) => WeChatDao.getWeChatArticleList(model.id, index),
              onResultData: (datas) => addArticleList(datas),
            );
          },
          receiveData: (data) => addArticleList(data.datas),
        ),
      )
    );
  }

}