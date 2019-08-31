import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import '../model/project/project_category_model.dart';
import '../dao/program_page_dao.dart';
import 'package:provider/provider.dart';
import '../provider/project_provider.dart';
import 'project_articles_page.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin ,SingleTickerProviderStateMixin{

  //tab数量动态，不能使用DefaultTabController控制器，需要使用这个，在tab数量发生变化时，动态创建
  TabController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0,length: 0,vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    _controller?.dispose();
  }

  //AppBar组件
  Widget _appBar(List<ProjectCategoryModel> categoryList) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "项目",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      bottom: _tabBars(categoryList),
    );
  }

  //顶部Tab切换TabBar组件
  Widget _tabBars(List<ProjectCategoryModel> categoryList) {
    return TabBar(
      isScrollable: true,
      controller: _controller,
      unselectedLabelColor: Colors.black26,
      labelColor: Colors.white,
      tabs: categoryList.map((item) {
        return Tab(
          child: Text(
            "${item.name}",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
    );
  }

  //每个项目分类下的页面
  Widget _categoryPagesView(List<ProjectCategoryModel> categoryList){
    return TabBarView(
      controller: _controller,
      children: categoryList.map((category){
        return ProjectCategoryPage(categoryModel:category);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProjectProvider>(
      builder: (context, provider, child) {
        return DynamicLoadingWidget<List<ProjectCategoryModel>>(
          asyncLoad: () => ProgramPageDao.getProgramCategoryList(),
          loadedWidget: (data){
            return Scaffold(
              backgroundColor: Colors.black12,
              appBar: _appBar(provider.programCategoryList),
              body: _categoryPagesView(provider.programCategoryList),
            );
          },
          receiveData: (data){
            _controller = TabController(initialIndex: 0,length: data.length,vsync: this); //根据tab数据重新创建TabController
            provider.addProgramCategoryList(data);
          },
        );
      },
    );
  }

}
