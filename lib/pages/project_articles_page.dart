import 'package:flutter/material.dart';
import '../model/article/article_page_model.dart';
import '../widget/dynamic_loading_widget.dart';
import '../widget/refresh_widget.dart';
import '../provider/project_provider.dart';
import '../widget/article_item_widget.dart';
import '../dao/program_page_dao.dart';
import '../model/project/project_category_model.dart';
import 'package:provider/provider.dart';
import '../model/common/common_model.dart';

//项目页面中的每个Tab(二级分类)对应的文章列表页面
class ProjectCategoryPage extends StatefulWidget {

  //传入的二级分类数据
  final ProjectCategoryModel categoryModel;

  ProjectCategoryPage({this.categoryModel});

  _ProjectCategoryPageState createState() => _ProjectCategoryPageState();
}

class _ProjectCategoryPageState extends State<ProjectCategoryPage> with AutomaticKeepAliveClientMixin{

  int _cid = 0;

  @override
  void initState() {
    super.initState();
    _cid = widget.categoryModel.id;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Consumer<ProjectProvider>(
        builder: (context,provider,child){
          return DynamicLoadingWidget<ArticlePageModel>(
            asyncLoad: () => ProgramPageDao.getArticleListByCidAndPageIndex(1, _cid),
            loadedWidget: (data){
              return RefreshWidget<CommonModel>(
                initialPageIndex: 1, //页码从第1页开始
                child: ListView.builder(
                  itemCount: provider.getItemCount(_cid),
                  itemBuilder: (context,index){
                    return ArticleItemWidget(data:provider.getArticleList(_cid)[index]);
                  },
                ),
                onLoadMore: (index) => ProgramPageDao.getArticleListByCidAndPageIndex(index, _cid),
                onResultData: (datas) => provider.addProgramPageByCid(_cid, datas),
              );
            },
            receiveData: (data) => provider.addProgramPageByCid(_cid, data.datas),
          );
        },
      ),
    );
  }

}