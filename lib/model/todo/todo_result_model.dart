import 'todo_model.dart';
import '../base_result_model.dart';

//添加或者修改Todo的响应结果model
class TodoResultModel extends BaseResultModel<TodoModel>{

  TodoResultModel({TodoModel data, Map<String,dynamic> json})
      :super(data:data,json:json);

  factory TodoResultModel.fromJson(Map<String, dynamic> json) {
    return TodoResultModel(
      data: json["data"] == null ? null : TodoModel.fromJson(json["data"]),
      json:json
    );
  }

}