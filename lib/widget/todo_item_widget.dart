import 'package:flutter/material.dart';
import '../model/todo/todo_model.dart';
import '../utils/screen_util.dart';
import '../utils/widget_utils.dart';
import '../pages/todo_edit_page.dart';
import '../dao/todo_dao.dart';
import '../model/base_result_model.dart';
import '../provider/todo_provider.dart';
import 'package:provider/provider.dart';

//Todo列表item
class TodoItemWidget extends StatelessWidget {
  final TodoModel model;

  TodoItemWidget({this.model});

  //标题组件
  Widget _titleWidget() {
    return Text(
      "标题：${model.title}",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 17),
    );
  }

  //内容组件
  Widget _contentWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(5)),
      child: Text(
        "内容：${model.content}",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }

  //预期完成时间组件
  Widget _setupCompleteDateWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(5)),
      child: Text(
        "预期完成：${model.dateStr}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }

  //类型组件
  Widget _typeWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(5)),
      child: Text(
        "类别：${TodoModel.types[model.type]}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }

  //标签tag
  Widget _tagWidget(String title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.red)),
      margin: EdgeInsets.all(ScreenUtils.width(5)),
      padding: EdgeInsets.all(ScreenUtils.width(3)),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.red),
      ),
    );
  }

  //删除按钮
  Widget _deleteWidget(context) {
    return Positioned(
      right: ScreenUtils.width(10),
      bottom: ScreenUtils.width(18),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
              left: ScreenUtils.width(20), right: ScreenUtils.width(10)),
          child: Image.asset(
            "images/delete.png",
            width: ScreenUtils.width(30),
            height: ScreenUtils.width(30),
          ),
        ),
        onTap: () {
          TodoDao.deleteToById(model.id).then((result){
            if(result.resultCode == BaseResultModel.STATE_OK){
              showToast("删除成功");
              Provider.of<TodoProvider>(context).removeTodo(model);
            }else{
              showToast("${result.errorMsg}");
            }
          });
        },
      ),
    );
  }

  //完成按钮
  Widget _doneWidget(context){
    return Positioned(
      right: ScreenUtils.width(70),
      bottom: ScreenUtils.width(18),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
              left: ScreenUtils.width(20), right: ScreenUtils.width(10)),
          child: Image.asset(
            "images/done.png",
            width: ScreenUtils.width(30),
            height: ScreenUtils.width(30),
          ),
        ),
        onTap: (){
          TodoDao.completeTodoById(model.id).then((result){
            if(result.resultCode == BaseResultModel.STATE_OK){
              showToast("恭喜您，完成一个Todo，加油哦!");
              Provider.of<TodoProvider>(context).updateTodoStatus(result.data);
            }else{
              showToast("${result.errorMsg}");
            }
          });
        },
      ),
    );
  }

  //底部标签显示组件
  Widget _bottomRowWidget(context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(5)),
      child: Row(
        children: <Widget>[
          _tagWidget(TodoModel.priorities[model.priority]),
          _tagWidget(TodoModel.statuses[model.status]),
        ],
      ),
    );
  }

  //todo列表项
  Widget _itemWidget(context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(ScreenUtils.width(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleWidget(),
            _contentWidget(),
            _setupCompleteDateWidget(),
            _typeWidget(),
            _bottomRowWidget(context)
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed("/todo_edit_page",arguments: {"pageType":PageType.EDIT_TODO,"data":model});
      },
    );
  }

  Widget _statusImageWidget(){
    return Positioned(
      right: ScreenUtils.width(10),
      top: ScreenUtils.width(10),
      child: Image.asset(
        model.status == TodoModel.COMPLETE ? "images/complete.png" : "images/uncomplete.png",
        width:ScreenUtils.width(80),
        height:ScreenUtils.width(80)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(12)),
      child: Material(//点击水波纹效果
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _itemWidget(context),
            _statusImageWidget(),
            _deleteWidget(context),
            _doneWidget(context)
          ],
        )
      ),
    );
  }
}
