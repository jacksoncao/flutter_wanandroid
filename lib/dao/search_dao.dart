//搜索Dao
import '../model/hotkey/search_hotkey_result_model.dart';
import '../model/article/article_page_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';

class SearchDao{

  //搜索文章接口
  static Future<ArticlePageResultModel> getArticlesBySearchKey(String key,int pageIndex) async{
    Map<String,dynamic> json = await NetUtils.post(Api.SEARCH+"$pageIndex/json",params: {"k":key});
    return ArticlePageResultModel.fromJson(json);
  }

  //搜索热词接口
  static Future<SearchHotKeyResultModel> getSearchHotkey() async{
    Map<String,dynamic> json = await NetUtils.get(Api.SEARCH_HOT_KEY);
    return SearchHotKeyResultModel.fromJson(json);
  }

}