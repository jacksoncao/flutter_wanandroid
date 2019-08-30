
import '../common/common_model.dart';

//导航一级分类（导航项）model  每个分类中都包含该分类下的所有的二级分类（子导航项）
class NavigationCategoryModel{
  final List<CommonModel> naviItems; //包含的二级分类(子导航项)
  final int cid; //导航分类id
  final String name; //导航名称

  NavigationCategoryModel({this.naviItems,this.cid,this.name});

  factory NavigationCategoryModel.fromJson(Map<String,dynamic> json){
    var naviItemsJson = json["articles"] as List;
    return NavigationCategoryModel(
      naviItems: naviItemsJson == null ? [] : naviItemsJson.map((item) => CommonModel.fromJson(item)).toList(),
      cid: json["cid"],
      name: json["name"]
    );
  }

}