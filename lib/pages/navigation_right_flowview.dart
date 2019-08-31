import 'dart:math';
import 'package:flutter/material.dart';
import '../model/common/common_model.dart';
import 'package:provider/provider.dart';
import '../provider/navigation_provider.dart';
import '../utils/screen_util.dart';
import 'detail_page.dart';


class NavigationRightFlowView extends StatelessWidget {

  final Random mRandom = new Random();
  
  //二级导航item，并在外层添加点击事件
  Widget _naviItem(context,CommonModel model){
    return Container(
        height: ScreenUtils.width(50),
        child: FlatButton(
          child: Text("${model.title}",style: TextStyle(color: Colors.white,fontSize: 15),),
          color: Color.fromARGB(255, mRandom.nextInt(255), mRandom.nextInt(255), mRandom.nextInt(255)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: (){
            Navigator.of(context).pushNamed("/detail_page",
                arguments: {"data":{"id":model.id,"name":model.title,"link":model.link},"type":PageType.INNER_WAP});
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    //获取Provider，也可以使用Consumer组件得到Provider
    NavigationProvider provider = Provider.of<NavigationProvider>(context);
    return Container(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topLeft,
            width: ScreenUtils.width(340),
            padding: EdgeInsets.all(ScreenUtils.width(10)),
            //使用流式组件来实现
            child: Wrap(
              spacing: ScreenUtils.width(10),
              runSpacing: ScreenUtils.width(10),
              children: provider.naviModelList.map((model) => _naviItem(context,model)).toList(),
            ),
          ),
      ),
    );
  }
}