import '../article/article_page_model.dart';
import '../base_result_model.dart';
//收藏文章页面列表数据响应结果model
class CollectionArticlesResultModel extends BaseResultModel<ArticlePageModel>{

  CollectionArticlesResultModel({ArticlePageModel data,Map<String,dynamic> json})
    :super(data:data,json:json);

  factory CollectionArticlesResultModel.fromJson(Map<String,dynamic> json){
    return CollectionArticlesResultModel(
      data: json["data"] == null ? null : ArticlePageModel.fromJson(json["data"]),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.datas == null || data.datas.length == 0;
  }

}