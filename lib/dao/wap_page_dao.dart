import '../utils/net_utils.dart';
import '../api/api.dart';
import '../model/wap/wap_result_model.dart';

class WapDao{

  //常用网站接口数据
  static Future<WapResultModel> getWapList() async{
    Map<String,dynamic> wapJson = await NetUtils.get(Api.FRIEND_WAP);
    return WapResultModel.fromJson(wapJson);
  }

}