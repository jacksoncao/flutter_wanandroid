import 'article_page_model.dart';
import '../base_result_model.dart';

//请求一页文章列表数据结果model
class ArticlePageResultModel extends BaseResultModel<ArticlePageModel> {

  ArticlePageResultModel({ArticlePageModel data, Map<String,dynamic> json})
      :super(data:data,json:json);

  factory ArticlePageResultModel.fromJson(Map<String, dynamic> json) {
    return ArticlePageResultModel(
      data: ArticlePageModel.fromJson(json["data"]),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.datas == null || data.datas.length == 0;
  }

}
