import 'package:flutter/material.dart';
import '../model/navigation/navigation_category_model.dart';
import '../model/common/common_model.dart';

//导航页面状态管理
class NavigationProvider extends ChangeNotifier{

  List<NavigationCategoryModel> _naviList = [];

  int _selectedIndex = 0;

  List<CommonModel> _modelList = [];

  int get selectedIndex => _selectedIndex;

  List<NavigationCategoryModel> get naviList => _naviList;

  List<CommonModel> get naviModelList => _modelList;

  addNaviModelList(List<NavigationCategoryModel> naviList){
    if(naviList != null && naviList.length > 0){
      _naviList.addAll(naviList);
      _modelList = naviList[_selectedIndex].naviItems;
      notifyListeners();
    }
  }

  selectIndex(int index){
    _selectedIndex = index;
    _modelList = _naviList[index].naviItems;
    notifyListeners();
  }

}