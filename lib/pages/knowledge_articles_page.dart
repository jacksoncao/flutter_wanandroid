import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/model/article/article_page_model.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import '../model/knowledge/knowledge_category_model.dart';
import 'package:flutter_wananzhuo/widget/article_item_widget.dart';
import 'package:flutter_wananzhuo/widget/refresh_widget.dart';
import '../utils/widget_utils.dart';
import '../dao/knowledge_page_dao.dart';
import '../model/common/common_model.dart';

//知识二级分类下的文章列表页面
class KnowledgeArticlesPage extends StatefulWidget {
  
  final KnowledgeCategoryModel arguments;

  KnowledgeArticlesPage({this.arguments});

  _KnowledgeArticlesPageState createState() => _KnowledgeArticlesPageState();
}

class _KnowledgeArticlesPageState extends State<KnowledgeArticlesPage> {

  List<CommonModel> _articleList = [];
  int _cid = 0;

  addKnowledgeArticleList(List<CommonModel> datas){
    if(datas != null && datas.length > 0){
      setState(() {
        _articleList.addAll(datas);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cid = widget.arguments.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(widget.arguments.name,centerTitle: false),
        body: Container(
          alignment: Alignment.center,
          color: Colors.black12,
          child: DynamicLoadingWidget<ArticlePageModel>( //动态加载页面组件
            asyncLoad: () => KnowledgePageDao.getArticleListByCidAndPageIndex(0, _cid),
            loadedWidget: (data){
              return RefreshWidget<CommonModel>(  //上拉加载更多组件
                child: ListView.builder(
                  itemCount: _articleList.length,
                  itemBuilder: (context,index){
                    return ArticleItemWidget(data:_articleList[index]);
                  },
                ),
                onLoadMore: (index) => KnowledgePageDao.getArticleListByCidAndPageIndex(index, widget.arguments.id),
                onResultData: (datas) => addKnowledgeArticleList(datas),
              );
            },
            receiveData: (data) => addKnowledgeArticleList(data.datas),
          )
        ),
      );
  }

}