import 'package:flutter/material.dart';
import '../model/article/article_page_model.dart';
import '../widget/dynamic_loading_widget.dart';
import '../widget/article_item_widget.dart';
import '../widget/refresh_widget.dart';
import '../dao/collection_dao.dart';
import '../model/common/common_model.dart';

//我的收藏--收藏文章列表  保存状态使用StatefulWidget
class CollectionArticlesPage extends StatefulWidget {
  CollectionArticlesPage({Key key}) : super(key: key);

  _CollectionArticlesPageState createState() => _CollectionArticlesPageState();
}

class _CollectionArticlesPageState extends State<CollectionArticlesPage> with AutomaticKeepAliveClientMixin{

  List<CommonModel> _articleList = [];

  addArticleList(List<CommonModel> articleList){
    if(articleList != null && articleList.length > 0){
      setState(() {
        _articleList.addAll(articleList);
      });
    }
  }
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black12,
      child: DynamicLoadingWidget<ArticlePageModel>(
        asyncLoad: () => CollectionDao.getCollectionArticleList(0),
        loadedWidget: (data){
          return RefreshWidget<CommonModel>(
            child: ListView.builder(
              itemCount: _articleList.length,
              itemBuilder: (context,index) => ArticleItemWidget(data:_articleList[index],itemType: Type.COLLECT_LIST,),
            ),
            onLoadMore: (index) => CollectionDao.getCollectionArticleList(index),
            onResultData: (datas) => addArticleList(datas),
          );
        },
        receiveData: (data) => addArticleList(data.datas),
      )
    );
  }

}