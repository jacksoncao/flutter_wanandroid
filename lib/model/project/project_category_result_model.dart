import '../base_result_model.dart';
import 'project_category_model.dart';

//项目分类请求响应结果数据model
class ProjectCategoryResultModel extends BaseResultModel<List<ProjectCategoryModel>>{

  ProjectCategoryResultModel({List<ProjectCategoryModel> data,Map<String,dynamic> json})
    :super(data:data,json:json);

  factory ProjectCategoryResultModel.fromJson(Map<String,dynamic> json){
    var projectCategoryListJson = json["data"] as List;
    return ProjectCategoryResultModel(
      data: projectCategoryListJson == null ? [] : projectCategoryListJson.map((item) => ProjectCategoryModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}