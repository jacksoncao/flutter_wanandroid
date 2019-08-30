import '../model/wechat/wechat_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';
import '../model/article/article_page_result_model.dart';
//微信公众号数据接口
class WeChatDao{

  //公众号列表数据接口调用
  static Future<WeChatResultModel> getWeChatList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.WECHAT_LIST);
    return WeChatResultModel.fromJson(json);
  }

  //获取某个公众号中的一页文章列表数据接口调用
  static Future<ArticlePageResultModel> getWeChatArticleList(int wxid,int pageIndex) async{
    Map<String,dynamic> json = await NetUtils.get(Api.WECHAT_ARTICLE_LIST+"$wxid/$pageIndex/json");
    return ArticlePageResultModel.fromJson(json);
  }

}