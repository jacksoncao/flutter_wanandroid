
import '../model/todo/todo_result_model.dart';
import '../model/todo/todo_page_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';
import '../model/todo/todo_model.dart';

class TodoDao{

  //查询一页todo信息
  static Future<TodoPageResultModel> getTodoList(int pageIndex,int status) async{
    Map<String,dynamic> json = await NetUtils.post(Api.TODO_LIST+"$pageIndex/json",params:{"status":"$status"});
    return TodoPageResultModel.fromJson(json);
  }

  //更新一个todo信息
  static Future<TodoResultModel> updateTodoById(int id,Map<String,String> params) async{
    Map<String,dynamic> json = await NetUtils.post(Api.TODO_UPDATE+"$id/json",params:params);
    return TodoResultModel.fromJson(json);
  }

  //添加一个Todo
  static Future<TodoResultModel> addTodo(Map<String,String> params) async{
    Map<String,dynamic> json = await NetUtils.post(Api.TODO_ADD,params:params);
    return TodoResultModel.fromJson(json);
  }

  //删除一个Todo
  static Future<TodoResultModel> deleteToById(int id) async{
    Map<String,dynamic> json = await NetUtils.post(Api.TODO_DELETE+"/$id/json");
    return TodoResultModel.fromJson(json);
  }

  //更新完成状态Todo
  static Future<TodoResultModel> completeTodoById(int id) async{
    Map<String,dynamic> json = await NetUtils.post(Api.TODO_COMPLETE+"/$id/json",params:{"status":"${TodoModel.COMPLETE}"});
    return TodoResultModel.fromJson(json);
  }

}