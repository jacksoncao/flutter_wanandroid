import 'package:flutter/material.dart';
import '../model/todo/todo_model.dart';
import '../utils/widget_utils.dart';
import '../utils/screen_util.dart';
import '../widget/radio_title_widget.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:date_format/date_format.dart';
import '../dao/todo_dao.dart';
import '../model/base_result_model.dart';
import '../provider/todo_provider.dart';
import 'package:provider/provider.dart';

//添加和编辑共用一个页面
class TodoEditPage extends StatefulWidget {
  
  final Map arguments;

  TodoEditPage({this.arguments});

  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String _datestr = formatDate(DateTime.now(),["yyyy","-","mm","-","dd"]);
  int _status = TodoModel.UNCOMPLETE;  //状态
  int _type = TodoModel.TYPE_STUDY;  //类别
  int _priority = TodoModel.NORMAL;  //优先级
  int _id;
  PageType type = PageType.ADD_TODO;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData(){
    type = widget.arguments["pageType"];
    if(type == PageType.EDIT_TODO){
      TodoModel model = widget.arguments["data"];
      _titleController.text = model.title;
      _contentController.text = model.content;
      _datestr = model.dateStr;
      _status = model.status;
      _type = model.type;
      _priority = model.priority;
      _id = model.id;
    }
  }

  //通用输入框组件
  Widget _simpleTextFieldWidget(String labelStr,TextEditingController controller){
    return Container(
      height: ScreenUtils.width(65),
      margin: EdgeInsets.only(bottom:ScreenUtils.width(30)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelStr,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
        ),
        style: TextStyle(
          fontSize: 16
        ),
      ),
    );
  }

  //日期显示以及选择组件
  Widget _datePickerWidget(context){
    return Container(
      child: InkWell(
        child: Text(_datestr),
        onTap: (){
          DatePicker.showDatePicker(
            context,
            minDateTime: DateTime.parse("2010-01-01"),
            maxDateTime: DateTime.parse("2050-01-01"),
            initialDateTime: DateTime.parse(_datestr),
            dateFormat: "yyyy年-MM月-dd日",
            locale: DateTimePickerLocale.zh_cn,
            onConfirm: (dateTime,List<int> selectIndex){
              setState(() {
                _datestr = formatDate(dateTime,["yyyy","-","mm","-","dd"]);
              });
            }
          );
        },
      ),
    );
  }

  //完成时间行组件
  Widget _completeDateRowWidget(context){
    return Container(
      child: Row(
        children: <Widget>[
          Text("完成日期："),
          _datePickerWidget(context)
        ],
      ),
    );
  }

  //状态组件  包含  已完成   未完成
  Widget _statusWidget(){
    return type == PageType.ADD_TODO ? Container() :
     Container(
        margin: EdgeInsets.only(top: ScreenUtils.width(10)),
        child: Row(
          children: <Widget>[
            Text("状态："),
            RadioTitleWidget(
              title: "已完成",
              value: TodoModel.COMPLETE,
              groupValue: _status,
              onCheck: (value){
                showToast("状态不可修改");
              },
            ),
            RadioTitleWidget<int>(
              title: "未完成",
              value: TodoModel.UNCOMPLETE,
              groupValue: _status,
              onCheck: (value){
                showToast("状态不可修改");
              },
            )
          ],
        ),
      );
  }

  //类别选择组件
  Widget _typeWidget(){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(10)),
      child: Row(
        children: <Widget>[
          Text("类别："),
          RadioTitleWidget<int>(
            title: "学习",
            value: TodoModel.TYPE_STUDY,
            groupValue: _type,
            onCheck: (value){
              setState(() {
                 _type = value;
              });
            },
          ),
          RadioTitleWidget<int>(
            title: "工作",
            value: TodoModel.TYPE_WORK,
            groupValue: _type,
            onCheck: (value){
              setState(() {
                 _type = value;
              });
            },
          ),
          RadioTitleWidget<int>(
            title: "生活",
            value: TodoModel.TYPE_LIFE,
            groupValue: _type,
            onCheck: (value){
              setState(() {
                 _type = value;
              });
            },
          ),
          RadioTitleWidget<int>(
            title: "运动",
            value: TodoModel.TYPE_SPORT,
            groupValue: _type,
            onCheck: (value){
              setState(() {
                 _type = value;
              });
            },
          )
        ],
      ),
    );
  }

  //优先级选择组件
  Widget _priorityWidget(){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(10)),
      child: Row(
        children: <Widget>[
          Text("重要程度："),
          RadioTitleWidget<int>(
            title: "重要",
            value: TodoModel.IMPORTANT,
            groupValue: _priority,
            onCheck: (value){
              setState(() {
                 _priority = value;
              });
            },
          ),
          RadioTitleWidget<int>(
            title: "普通",
            value: TodoModel.NORMAL,
            groupValue: _priority,
            onCheck: (value){
              setState(() {
                 _priority = value;
              });
            },
          ),
        ],
      ),
    );
  }

  //提交按钮组件
  Widget _submitWidget(){
    return Container(
      width: double.maxFinite,
      height: ScreenUtils.width(55),
      margin: EdgeInsets.only(top: ScreenUtils.width(30)),
      child: RaisedButton(
        color: Colors.pinkAccent,
        child: Text("确认提交",style: TextStyle(color: Colors.white,fontSize: 17)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: (){
          String title = _titleController.text;
          String content = _contentController.text;
          if(title == null || title.length == 0 
            || content == null || content.length == 0
            || _datestr == null || _datestr.length == 0){
            showToast("标题，内容详情，完成时间为必填项!");
            return;
          }
          Map<String,String> params = {
            "title":title,"content":content,
            "date":_datestr,"type":"$_type",
            "priority":"$_priority"
          };
          if(type == PageType.ADD_TODO){
            _requestAddTodo(params);
          }else{
            _requestUpdateTodo(params);
          }
        },
      ),
    );
  }

  //添加一个Todo
  _requestAddTodo(Map<String,String> params){
    TodoDao.addTodo(params).then((result){
      if(result.resultCode == BaseResultModel.STATE_OK){
        showToast("添加成功");
        Provider.of<TodoProvider>(context).addTodo(result.data);
        Navigator.of(context).pop();
      }else{
        showToast("${result.errorMsg}");
      }
    });
  }

  //更新一个Todo
  _requestUpdateTodo(Map<String,String> params){
    TodoDao.updateTodoById(_id, params).then((result){
      if(result.resultCode == BaseResultModel.STATE_OK){
        showToast("修改成功");
        Provider.of<TodoProvider>(context).updateTodo(result.data);
        Navigator.of(context).pop();
      }else{
        showToast("${result.errorMsg}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(type == PageType.ADD_TODO ? "添加Todo":"编辑Todo"),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(ScreenUtils.width(30)),
          child: Column(
            children: <Widget>[
              _simpleTextFieldWidget("标题:",_titleController),
              _simpleTextFieldWidget("内容:",_contentController),
              _completeDateRowWidget(context),
              _statusWidget(),
              _typeWidget(),
              _priorityWidget(),
              _submitWidget()
            ],
          ),
        )
      ),
    );
  }
}

enum PageType{

  EDIT_TODO, //编辑todo页面

  ADD_TODO //添加todo页面

}
