
import '../base_result_model.dart';
import 'navigation_category_model.dart';

//导航分类请求响应结果数据model，一次性返回所有的数据，没有分页返回
class NavigationCategoryResultModel extends BaseResultModel<List<NavigationCategoryModel>>{

  NavigationCategoryResultModel({List<NavigationCategoryModel> data,Map<String,dynamic> json})
    :super(data:data,json:json);

  factory NavigationCategoryResultModel.fromJson(Map<String,dynamic> json){
    var naviCategoryListJson = json["data"] as List;
    return NavigationCategoryResultModel(
      data: naviCategoryListJson == null ? [] : naviCategoryListJson.map((item) => NavigationCategoryModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}