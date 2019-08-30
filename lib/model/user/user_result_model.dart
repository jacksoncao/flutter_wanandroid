
import 'user_model.dart';
import '../base_result_model.dart';

//用户信息请求结果model
class UserResultModel extends BaseResultModel<UserModel>{

  UserResultModel({UserModel data,Map<String,dynamic> json})
      :super(data:data,json:json);

  //如果用户名已经被注册或者其他失败情况返回的json中data为null
  factory UserResultModel.fromJson(Map<String,dynamic> json){
    return UserResultModel(
      data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      json:json
    );
  }

}