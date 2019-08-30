
import '../model/collection/collection_page_result_model.dart';
import '../api/api.dart';
import '../utils/net_utils.dart';
import '../model/base_result_model.dart';

class CollectionDao{

  //收藏页面收藏列表接口，后台接口页码从第0页开始
  static Future<CollectionArticlesResultModel> getCollectionArticleList(int pageIndex) async{
    Map<String,dynamic> json = await NetUtils.get(Api.COLLECT_ARTICLE_LIST+"$pageIndex/json");
    return CollectionArticlesResultModel.fromJson(json);
  }

  //取消收藏网址
  static Future<BaseResultModel> uncollectWap(int id) async{
    Map<String,dynamic> json = await NetUtils.post(Api.UNCOLLECT_WAP,params: {"id":"$id"});
    return BaseResultModel.from(json);
  }

  //取消收藏接口 
  static Future<BaseResultModel> uncollectArticle(int id) async{
    Map<String,dynamic> json = await NetUtils.post(Api.UNCOLLECT_ARTICLE_LIST_ITEM +"$id/json");
    return BaseResultModel.from(json);
  }

  //取消收藏页中已收藏文章的接口  取消收藏需要传入originId参数
  static Future<BaseResultModel> uncollectCollectPageArticle(int id,int originId) async{
    Map<String,dynamic> json = await NetUtils.post(Api.COLLECT_PAGE_UNCOLLECT_ARTICLE +"$id/json",params:{"originId":"$originId"});
    return BaseResultModel.from(json);
  }

  //收藏接口  收藏网页
  static Future<BaseResultModel> collectWap(String name,String link) async{
    Map<String,dynamic> json = await NetUtils.post(Api.COLLECT_WAP,params: {"name":name,"link":link});
    return BaseResultModel.from(json);
  }

  //收藏接口  收藏站内文章
  static Future<BaseResultModel> collectArticle(int id) async{
    Map<String,dynamic> json = await NetUtils.post(Api.COLLECT_ARTICLE +"$id/json");
    return BaseResultModel.from(json);
  }
  
}