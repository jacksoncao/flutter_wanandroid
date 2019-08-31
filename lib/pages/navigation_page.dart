import 'package:flutter/material.dart';
import '../widget/dynamic_loading_widget.dart';
import '../dao/navigation_page_dao.dart';
import '../pages/navigation_right_flowview.dart';
import '../utils/screen_util.dart';
import 'package:provider/provider.dart';
import '../provider/navigation_provider.dart';
import 'navigation_left_listview.dart';
import '../utils/widget_utils.dart';
import '../model/navigation/navigation_category_model.dart';

//导航页面：显示左右两边操作区域   
//  --> 左边显示一级分类竖直ListView   
//  --> 右边显示成流式标签
class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with AutomaticKeepAliveClientMixin{
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: commonAppBar("导航",centerTitle: true),
      body: DynamicLoadingWidget<List<NavigationCategoryModel>>(
        asyncLoad: () => NavigationPageDao.getNavigationCategroyList(),
        loadedWidget: (data){
          return Container(
            child: Row(
              children: <Widget>[
                //左边视图
                NavigationLeftListView(width: ScreenUtils.width(140),),
                //右边视图
                NavigationRightFlowView()
              ],
            ),
          );
        },
        receiveData: (data) => Provider.of<NavigationProvider>(context).addNaviModelList(data),
      ),
    );
  }

}
