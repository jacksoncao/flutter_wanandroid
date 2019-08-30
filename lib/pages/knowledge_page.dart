import 'package:flutter/material.dart';
import '../widget/dynamic_loading_widget.dart';
import '../provider/knowledge_provider.dart';
import '../dao/knowledge_page_dao.dart';
import '../model/knowledge/knowledge_category_model.dart';
import 'package:provider/provider.dart';
import '../utils/screen_util.dart';
import '../utils/widget_utils.dart';

//知识体系页面   以表格的方式展示一级分类以及下面的所有的二级分类
class KnowledgePage extends StatefulWidget {
  KnowledgePage({Key key}) : super(key: key);

  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> with AutomaticKeepAliveClientMixin{

  @protected
  bool get wantKeepAlive => true;

  //每个知识类别item组件  使用Table组件来实现
  Widget _knowledgeCategoryItem(KnowledgeCategoryModel item){
    return Container(
      child: Column(
        children: <Widget>[
          _parentCategoryItemTitle(item),
          _childCategoryItemTable(item)
        ],
      ),
    );
  }

  //知识类别组件顶部的title组件  显示父类别的名称
  Widget _parentCategoryItemTitle(KnowledgeCategoryModel item){
    return Container(
      padding: EdgeInsets.all(ScreenUtils.width(10)),
      child: Text(
        "${item.name}",
        style:TextStyle(
          fontSize:16,
          color:Colors.red
        )
      ),
    );
  }

  //知识类别组件中的表格   table中显示该一级分类下的所有的二级分类
  Widget _childCategoryItemTable(KnowledgeCategoryModel item){
    if(item.children == null || item.children.length == 0){
      return Container();
    }else{
      return Container(
        child: Table(
          border: TableBorder.all(color: Colors.pinkAccent),
          children: _childCategoryItemRows(item.children),
        ),
      );
    }
  }

  //每个一级分类下的二级分类的TableRow集合
  List<TableRow> _childCategoryItemRows(List<KnowledgeCategoryModel> childItems){
    List<TableRow> rowList = [];
    List<KnowledgeCategoryModel> categoryList = [];
    TableRow row;
    int remainder = childItems.length % 3;
    //对于最后一行TableRow如果数据不足，填充null，进行数据占位
    for(int i=0;remainder != 0 && i<3-remainder;i++){
      childItems.add(null);
    }
    childItems.forEach((item){
      if(categoryList.length < 2){
        categoryList.add(item);
      }else{
        categoryList.add(item);
        row = TableRow(
          //判断当前的数据是否是人为填充的null，人为填充的则使用空的Container进行占位
          children: categoryList.map((item) => (item == null ? _childCategoryEmptyCell() : _childCategoryCell(item))).toList(),
        );
        //创建TableRow后，清空集合中的数据，为创建下一个TableRow做准备
        categoryList.clear();
        rowList.add(row);
      }
    });
    return rowList;
  }

  //每个二级类别的cell组件
  Widget _childCategoryCell(KnowledgeCategoryModel item){
    return InkWell(
      child: Container(
        height: ScreenUtils.width(45),
        alignment: Alignment.center,
        padding: EdgeInsets.all(ScreenUtils.width(8)),
        child: Text(
          "${item.name}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed("/knowledge_articles_page",arguments: item);
      },
    );
  }

  //因为每个TableRow中的cell数量要一致，所以对于数据不足的时候，使用Container进行填充
  Widget _childCategoryEmptyCell(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: commonAppBar("知识体系",centerTitle:true),
      body: Consumer<KnowledgeProvider>(
        builder: (context,provider,child){
          return DynamicLoadingWidget<List<KnowledgeCategoryModel>>(
            asyncLoad: () => KnowledgePageDao.getKnowledgeCategoryList(),
            loadedWidget: (data){
              return ListView.builder(
                padding: EdgeInsets.all(ScreenUtils.width(10)),
                itemCount: provider.knowledgeCategoryList.length,
                itemBuilder: (context,index){
                  //ListView的每一项 ==> 一个Text组件 + 一个Table组件
                  return _knowledgeCategoryItem(provider.knowledgeCategoryList[index]);
                },
              );
            },
            receiveData: (data) => Provider.of<KnowledgeProvider>(context).addKnowledgeCategoryList(data),
          );
        },
      ),
    );
  }

}