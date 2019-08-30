import 'package:flutter/material.dart';
import '../model/project/project_category_model.dart';
import '../model/common/common_model.dart';

//项目页面状态管理
class ProjectProvider with ChangeNotifier{

  //项目分类Tab数据集合
  List<ProjectCategoryModel> _programCategoryList = [];

  List<ProjectCategoryModel> get programCategoryList => _programCategoryList;

  addProgramCategoryList(List<ProjectCategoryModel> categoryList){
    if(categoryList != null && categoryList.length > 0){
      _programCategoryList.addAll(categoryList);
      notifyListeners();
    }
  }

  /*
   * 项目分类下的二级分类对应的文章列表数据集合
   * key：项目二级分类的cid
   * value：该二级分类相关的列表数据集合  
   */
  Map<String,List<CommonModel>> _programMap = {};

  List<CommonModel> _getCidList(int cid){
    List<CommonModel> list = _programMap["$cid"];
    if(list == null){
      list = [];
      _programMap.addAll({"$cid":list});
    }
    return list;
  }

  int getItemCount(int cid){
    return _getCidList(cid).length;
  }

  List<CommonModel> getArticleList(int cid){
    return _getCidList(cid);
  }

  addProgramPageByCid(int cid,List<CommonModel> datas){
    if(datas != null){
      List<CommonModel> list = _getCidList(cid);
      if(datas.length > 0){
        list.addAll(datas);
      }
      notifyListeners();
    }
  }

}