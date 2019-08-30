
import '../common/common_model.dart';
import '../base_result_model.dart';

//置顶文章请求结果model
class TopArticleResultModel extends BaseResultModel<List<CommonModel>>{

  TopArticleResultModel({List<CommonModel> data, Map<String,dynamic> json})
      :super(data:data,json:json);

  factory TopArticleResultModel.fromJson(Map<String, dynamic> json) {
    var articleListJson = json["data"] as List;
    return TopArticleResultModel(
      data: articleListJson == null ? [] : articleListJson.map((item) => CommonModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}