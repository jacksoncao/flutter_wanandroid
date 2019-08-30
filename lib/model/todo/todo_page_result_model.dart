import 'todo_page_model.dart';
import '../base_result_model.dart';

//请求一页Todo数据的响应结果model
class TodoPageResultModel extends BaseResultModel<TodoPageModel>{

  TodoPageResultModel({TodoPageModel data,Map<String,dynamic> json})
      :super(data:data,json:json);

  factory TodoPageResultModel.fromJson(Map<String,dynamic> json){
    return TodoPageResultModel(
      data: TodoPageModel.fromJson(json["data"]),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.datas == null || data.datas.length == 0;
  }

}