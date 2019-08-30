import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{

  //存储登录用户信息的key
  static const String KEY_USER_DATA = "USER_DATA";

  static Future<bool> setInt(String key,int value) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.setInt(key, value);
  }

  static Future<int> getInt(String key) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getInt(key) ?? 0;
  }

  static Future<bool> setString(String key,String value) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.setString(key, value);
  }

  static Future<String> getString(String key) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key) ?? null;
  }

  static void removeString(String key) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    if(instance.containsKey(key)){
      instance.remove(key);
    }
  }

}