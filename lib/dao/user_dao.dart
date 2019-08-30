import '../model/user/user_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';
import '../utils/sp_utils.dart';
import 'dart:convert';
import '../model/base_result_model.dart';
import '../provider/user_provider.dart';

//用户注册，登录等相关接口
class UserDao{

  //用户注册接口调用
  static Future<UserResultModel> registerUser(String username,String password,String repassword) async{
    Map<String,dynamic> json = await NetUtils.post(Api.USER_REGISTER, params:{
      "username":username,
      "password":password,
      "repassword":repassword
    });
    UserResultModel model = UserResultModel.fromJson(json);
    if(model.resultCode == BaseResultModel.STATE_OK){
      saveLoginUser(username,password);
    }
    return model;
  }

  //用户登录接口调用
  static Future<UserResultModel> login(String username,String password) async{
    Map<String,dynamic> json = await NetUtils.post(Api.USER_LOGIN,params:{
      "username":username,
      "password":password,
    });
    UserResultModel model = UserResultModel.fromJson(json);
    if(model.resultCode == BaseResultModel.STATE_OK){
      saveLoginUser(username,password);
    }
    return model;
  }

  //用户退出登录接口调用
  static Future<UserResultModel> logout() async{
    Map<String,dynamic> json = await NetUtils.get(Api.USER_LOGOUT);
    UserResultModel model = UserResultModel.fromJson(json);
    if(model.resultCode == BaseResultModel.STATE_OK){
      SpUtils.removeString(SpUtils.KEY_USER_DATA);
    }
    return model;
  }

  //持久化用户信息到本地存储中
  static void saveLoginUser(String username,String password) async{
    String userJson = json.encode({"username":username,"password":password});
    bool result = await SpUtils.setString(SpUtils.KEY_USER_DATA, userJson);
    if(result){
      print("保存登录用户信息到本地文件中");
    }
  }

  //从本地持久化sp中查找存储的用户信息，如果有则代表已登录，没有则没有登录
  static Future<UserResultModel> getLoginUser() async{
    String userJson = await SpUtils.getString(SpUtils.KEY_USER_DATA);
    if(userJson != null){
      Map<String,dynamic> map = json.decode(userJson);
      print("本地找到用户名和密码信息，正在执行自动登录~~~~~~~~~~~~~");
      return await login(map["username"],map["password"]);
    }
    return null;
  }

  static void loadStorageLoginUser(UserProvider provider) async{
    UserResultModel result = await getLoginUser();
    if(result != null && result.resultCode == BaseResultModel.STATE_OK &&  result.data != null){
      provider.setLoginUser(result.data);
    }
  }

}