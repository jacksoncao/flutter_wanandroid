import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import 'package:flutter_wananzhuo/widget/refresh_widget.dart';
import 'package:flutter_wananzhuo/widget/todo_item_widget.dart';
import '../dao/todo_dao.dart';
import '../provider/todo_provider.dart';
import 'package:provider/provider.dart';
import '../model/todo/todo_model.dart';
import '../utils/screen_util.dart';

class TodoCompletePage extends StatefulWidget {
  TodoCompletePage({Key key}) : super(key: key);

  _TodoCompletePageState createState() => _TodoCompletePageState();
}

class _TodoCompletePageState extends State<TodoCompletePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("完成清单"),
      backgroundColor: Colors.black12,
      body: Consumer<TodoProvider>(
        builder: (context,provider,child){
          return DynamicLoadingWidget(
            asyncLoad: ()=>TodoDao.getTodoList(1, TodoModel.COMPLETE),
            preRefreshState: (controller) {
              if(provider.completeList.length == 0){
                controller.noData();
              }else{
                controller.loaded();
              }
            },
            loadedWidget: (data){
              return RefreshWidget( //上拉加载更多组件
                initialPageIndex: 1,
                onLoadMore: (index)=>TodoDao.getTodoList(index, TodoModel.COMPLETE),
                onResultData: (datas) => provider.addTodoList(false,TodoModel.COMPLETE, datas),
                child: ListView.builder(
                  itemCount: provider.completeList.length,
                  padding: EdgeInsets.only(left:ScreenUtils.width(12),right:ScreenUtils.width(12),bottom:ScreenUtils.width(12)),
                  itemBuilder: (context,index)=>TodoItemWidget(model:provider.completeList[index]),
                ),
              );
            },
            receiveData: (model) async{
              provider.addTodoList(true,TodoModel.COMPLETE, model.datas);
            },
          );
        },
      ),
    );
  }

}
