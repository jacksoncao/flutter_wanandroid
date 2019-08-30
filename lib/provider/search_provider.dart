
import 'package:flutter/foundation.dart';
import 'package:flutter_wananzhuo/model/hotkey/search_hotkey_model.dart';
import '../model/common/common_model.dart';

class SearchProvider with ChangeNotifier{

  //搜索结果数据集合
  List<CommonModel> _articles = [];

  List<CommonModel> get searchArticles => _articles;

  addArticleList(List<CommonModel> articleList){
    if(articleList != null && articleList.length > 0){
      _articles.addAll(articleList);
      notifyListeners();
    }
  }

  clearArticleList() => _articles=[];

  //------------------------------搜索热词---------------------------------

  List<SearchHotKeyModel> _hotkeyList = [];

  addSearchHotKeyList(List<SearchHotKeyModel> hotkeyList){
    if(hotkeyList != null && hotkeyList.length > 0){
      _hotkeyList = hotkeyList;
      notifyListeners();
    }
  }

  List<SearchHotKeyModel> get hotkeyList => _hotkeyList;


}