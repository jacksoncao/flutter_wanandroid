import 'package:flutter/material.dart';
import '../model/knowledge/knowledge_category_model.dart';
import '../model/common/common_model.dart';
import '../model/article/article_page_model.dart';

//知识体系相关状态管理内容
class KnowledgeProvider with ChangeNotifier{

  //--------------------------知识体系分类数据------------------------------------------

  List<KnowledgeCategoryModel> _knowledgeCategoryList = [];

  List<KnowledgeCategoryModel> get knowledgeCategoryList => _knowledgeCategoryList;

  void addKnowledgeCategoryList(List<KnowledgeCategoryModel> categoryList){
    if(categoryList != null && categoryList.length > 0){
      _knowledgeCategoryList.addAll(categoryList);
      notifyListeners();
    }
  }

  //-------------------------知识体系二级分类下的文章列表----------------------------------

  List<CommonModel> _articleList = [];

  List<CommonModel> get articleList => _articleList;

  addKnowledgeArticleList(ArticlePageModel pageModel){
    if(pageModel != null && pageModel.datas != null && pageModel.datas.length > 0){
      _articleList.addAll(pageModel.datas);
    }
  }

}