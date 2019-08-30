import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import '../utils/screen_util.dart';

//关于页面
class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  Widget _descriptionTitleWidget(){
    return Container(
      margin: EdgeInsets.only(left:ScreenUtils.width(10),right:ScreenUtils.width(10)),
      child: Text(
        "玩安卓(Flutter)客户端",
        overflow:TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 18,
          color: Colors.pinkAccent
        )
      ),
    );
  }

  Widget _descriptionContentWidget(){
    return Container(
      margin: EdgeInsets.all(ScreenUtils.width(10)),
      child: Text(
        "         此项目是Flutter的练习项目，项目中可能存在UI交互设计不合理，也可能是代码有不足之处，都欢迎批评指正。微信高级工程师邵文同学在android开发高手课中，有句话我一直是深有感触：技术发展日新月异，我们只能顺应时代，以积极心态去拥抱这些变化，不断地钻研技术的深度和扩展知识的广度，只有这样才能立于不败之地。与君共勉!",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("关于",centerTitle:false),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:ScreenUtils.width(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _descriptionTitleWidget(),
            _descriptionContentWidget()
          ],
        ),
      ),
    );
  }
}