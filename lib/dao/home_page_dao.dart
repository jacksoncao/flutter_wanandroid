import '../model/article/article_page_result_model.dart';
import '../model/banner/homebanner_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';
import '../model/article/toparticle_result_model.dart';

//首页相关页面数据
class HomePageDao{

  //解析网络返回的首页banner数据
  static Future<HomeBannerResultModel> getHomeBannerList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.HOME_BANNER);
    return HomeBannerResultModel.fromJson(json);
  }

  //置顶文章
  static Future<TopArticleResultModel> getTopArticleList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.TOP_ARTICLE);
    return TopArticleResultModel.fromJson(json);
  }

  //首页文章列表数据
  static Future<ArticlePageResultModel> getHomeArticleList(int page) async{
    Map<String,dynamic> json = await NetUtils.get(Api.HOME_ARTICLE_LIST+"$page/json");
    return ArticlePageResultModel.fromJson(json);
  }

}