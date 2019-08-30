import 'package:flutter/material.dart';
import '../model/banner/homebanner_model.dart';
import '../model/common/common_model.dart';

//首页状态管理内容
class HomeProvider with ChangeNotifier{

  //首页顶部banner轮播图
  List<HomeBannerItemModel> _bannerList = [];
  //首页文章列表，包括：普通文章列表   指定文章列表
  List<CommonModel> _articleList = [];

  List<HomeBannerItemModel> get bannerList => _bannerList;

  List<CommonModel> get articleList => _articleList;

  addHomeBannerList(List<HomeBannerItemModel> items){
    if(items != null && items.length > 0){
      _bannerList.addAll(items);
      notifyListeners();
    }
  }

  addHomePageArticle(List<CommonModel> datas){
    if(datas != null && datas.length > 0){
      _articleList.addAll(datas);
      notifyListeners();
    }
  }

  insertTopArticle(List<CommonModel> topArticleList){
    if(topArticleList != null && topArticleList.length > 0){
      _articleList.insertAll(0, topArticleList);
      notifyListeners();
    }
  }

}