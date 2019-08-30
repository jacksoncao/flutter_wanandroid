
import '../base_page_model.dart';
import '../common/common_model.dart';

//每次请求一页文章列表数据，文章item数据都封装在datas中
class ArticlePageModel extends BasePageModel<CommonModel>{
  
  ArticlePageModel({List<CommonModel> data,Map<String,dynamic> json})
      :super(datas:data,json:json);

  factory ArticlePageModel.fromJson(Map<String,dynamic> json){
    var datasJson = json["datas"] as List;
    return ArticlePageModel(
      data:datasJson == null ? [] : datasJson.map((item) => CommonModel.fromJson(item)).toList(),
      json: json
    );
  }

}