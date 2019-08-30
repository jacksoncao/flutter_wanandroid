
import 'package:flutter/material.dart';
import '../model/todo/todo_model.dart';

class TodoProvider with ChangeNotifier{

  //未完成todo集合数据
  List<TodoModel> _unCompleteList = []; 
  List<TodoModel> _completeList = [];

  List<TodoModel> get unCompleteList => _unCompleteList;
  List<TodoModel> get completeList => _completeList;

  //添加todo的方法
  addTodo(TodoModel model){
    if(model != null){
      addTodoList(false,model.status, [model]);
    }
  }

  //添加todo的方法
  addTodoList(bool reset,int status,List<TodoModel> list){
    if(list != null && list.length > 0){
      if(status == TodoModel.UNCOMPLETE){
        if(reset){
          _unCompleteList = list;
        }else{
          _unCompleteList.addAll(list);
        }
      }else{
        if(reset){
          _completeList = list;
        }else{
          _completeList.addAll(list);
        }
      }
      notifyListeners();
    }
  }

  //删除todo的方法
  removeTodo(TodoModel todoModel){
    if(todoModel != null){
      if(todoModel.status == TodoModel.COMPLETE){
        _completeList.remove(todoModel);
      }else{
        _unCompleteList.remove(todoModel);
      }
      notifyListeners();
    }
  }

  TodoModel _updateTodo(List<TodoModel> list,TodoModel model){
    if(list != null && list.length > 0){
      for(TodoModel item in list){
        if(item.id == model.id){
          item.title = model.title;
          item.content = model.content;
          item.dateStr = model.dateStr;
          item.priority = model.priority;
          item.type = model.type;
          item.status = model.status;
          return item;
        }
      }
    }
    return null;
  }

  //用于更新todo的其他信息的方法
  updateTodo(TodoModel todoModel){
    if(todoModel != null){
      _updateTodo(todoModel.status 
          == TodoModel.COMPLETE ? _completeList : _unCompleteList, todoModel);
      notifyListeners();
    }
  }

  //用于更新todo的状态的方法
  updateTodoStatus(TodoModel todoModel){
    if(todoModel != null){
      TodoModel item = _updateTodo(_unCompleteList, todoModel);
      if(item != null){
        _unCompleteList.remove(item);
        completeList.add(item);
        notifyListeners();
      }
    }
  }

}