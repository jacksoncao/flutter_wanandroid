import 'package:flutter/material.dart';
import '../model/user/user_model.dart';

//用户状态控制
class UserProvider with ChangeNotifier{


  //当前登录的用户对象信息
  UserModel  _loginUser;

  UserModel get loginUser => _loginUser;

  //收藏文章
  List<int> get collectionIds {
    if(_loginUser == null || _loginUser.collectIds == null){
      return [];
    }
    return _loginUser.collectIds;
  }

  //同步用户登录状态
  void setLoginUser(UserModel user){
    _loginUser = user;
    notifyListeners();
  }

  //取消收藏某文章
  void removeCollectionId(int id){
    if(_loginUser != null && _loginUser.collectIds != null){
      _loginUser.collectIds.remove(id);
      print("取消收藏文章$id");
      notifyListeners();
    }
  }

  //对某文章进行收藏
  void addCollectionId(int id){
    if(_loginUser != null && _loginUser.collectIds != null){
      _loginUser.collectIds.add(id);
      print("收藏文章$id");
      notifyListeners();
    }
  }

}