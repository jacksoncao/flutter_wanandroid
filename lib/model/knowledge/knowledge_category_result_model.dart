
import 'knowledge_category_model.dart';
import '../base_result_model.dart';

//知识体系分类请求响应结果model
class KnowledgeCategoryResultModel extends BaseResultModel<List<KnowledgeCategoryModel>>{

  KnowledgeCategoryResultModel({List<KnowledgeCategoryModel> data,Map<String,dynamic> json})
      :super(data:data,json:json);

  factory KnowledgeCategoryResultModel.fromJson(Map<String,dynamic> json){
    var knowledgeCategoryListJson = json["data"] as List;
    return KnowledgeCategoryResultModel(
      data: knowledgeCategoryListJson == null ? [] : knowledgeCategoryListJson.map((item) => KnowledgeCategoryModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}