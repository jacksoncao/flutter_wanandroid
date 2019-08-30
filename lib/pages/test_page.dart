import 'package:flutter/material.dart';
import '../model/base_result_model.dart';
import '../model/common/common_model.dart';
import '../widget/dynamic_loading_widget.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试页面"),
      ),
      body: DynamicLoadingWidget<CommonModel>(
        loadedWidget: (data){
          return Container(
            child: Text("数据加载成功"),
          );
        },
        asyncLoad: () async{
          print("加载数据");
          await Future.delayed(Duration(seconds: 3));
          return BaseResultModel<CommonModel>.from({"data":null,"errorCode":0,"errorMsg":""});
        },
      ),
    );
  }
}