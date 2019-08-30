import '../model/article/article_page_result_model.dart';
import '../model/knowledge/knowledge_category_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';

//知识体系相关页面数据
class KnowledgePageDao{

  //知识体系的一级分类集合数据，一级分类中包含了该分类下的所有二级分类
  static Future<KnowledgeCategoryResultModel> getKnowledgeCategoryList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.KNOWLEDGE_CATEGORY);
    return KnowledgeCategoryResultModel.fromJson(json);
  }

  //知识体系分类下的文章列表数据，页码从第0页开始
  static Future<ArticlePageResultModel> getArticleListByCidAndPageIndex(int pageIndex,int cid) async{
    Map<String,dynamic> json = await NetUtils.get(Api.KNOWLEDGE_CATEGORY_ARTICLES + "$pageIndex/json?cid=$cid");
    return ArticlePageResultModel.fromJson(json);
  }


}