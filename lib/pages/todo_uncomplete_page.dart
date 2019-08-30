import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import 'package:flutter_wananzhuo/widget/refresh_widget.dart';
import '../widget/todo_item_widget.dart';
import '../utils/widget_utils.dart';
import '../dao/todo_dao.dart';
import '../utils/screen_util.dart';
import '../provider/todo_provider.dart';
import 'package:provider/provider.dart';
import '../model/todo//todo_model.dart';
import 'todo_edit_page.dart';
import '../model/todo/todo_page_model.dart';

//Todo未完成tab页面
class TodoUnCompletePage extends StatefulWidget {
  TodoUnCompletePage({Key key}) : super(key: key);

  _TodoUnCompletePageState createState() => _TodoUnCompletePageState();
}

class _TodoUnCompletePageState extends State<TodoUnCompletePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("待办清单",actions: [
        IconButton(
          icon: Icon(Icons.add_circle_outline,color: Colors.white,size: ScreenUtils.width(35),),
          onPressed: (){
            Navigator.of(context).pushNamed("/todo_edit_page",arguments: {"pageType":PageType.ADD_TODO});
          },
        )
      ]),
      backgroundColor: Colors.black12,
      body: Consumer<TodoProvider>(
        builder: (context,provider,child){
          return DynamicLoadingWidget<TodoPageModel>(
            asyncLoad: ()=>TodoDao.getTodoList(1, TodoModel.UNCOMPLETE),
            preRefreshState: (controller) {
              if(provider.unCompleteList.length == 0){
                controller.noData();
              }else{
                controller.loaded();
              }
            }, 
            loadedWidget: (data){
              return RefreshWidget(
                initialPageIndex: 1,
                onLoadMore: (index)=>TodoDao.getTodoList(index, TodoModel.UNCOMPLETE),
                onResultData: (datas)=>provider.addTodoList(false,TodoModel.UNCOMPLETE, datas),
                child: ListView.builder(
                  itemCount: provider.unCompleteList.length,
                  padding: EdgeInsets.only(left:ScreenUtils.width(12),right:ScreenUtils.width(12),bottom:ScreenUtils.width(12)),
                  itemBuilder: (context,index){
                      return TodoItemWidget(model:provider.unCompleteList[index]);
                  },
                ),
              );
            },
            receiveData: (model) async{
              provider.addTodoList(true,TodoModel.UNCOMPLETE, model.datas);
            },
          );
        }
      )
    );
  }

}

