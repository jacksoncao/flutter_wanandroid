import '../base_page_model.dart';
import 'todo_model.dart';

//一页Todo数据的model
class TodoPageModel extends BasePageModel<TodoModel>{

  TodoPageModel({List<TodoModel> data,Map<String,dynamic> json})
    :super(datas:data,json:json);

  factory TodoPageModel.fromJson(Map<String,dynamic> json){
    var datasJson = json["datas"] as List;
    return TodoPageModel(
      data: datasJson == null ? [] : datasJson.map((item) => TodoModel.fromJson(item)).toList(),
      json:json
    );
  }
  
}