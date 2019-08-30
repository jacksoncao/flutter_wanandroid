import 'wechat_model.dart';
import '../base_result_model.dart';

//微信公众号请求结果model，直接返回所有的数据，没有用到分页返回
class WeChatResultModel extends BaseResultModel<List<WeChatModel>>{

  WeChatResultModel({List<WeChatModel> data,Map<String,dynamic> json})
        :super(data:data,json:json);

  factory WeChatResultModel.fromJson(Map<String,dynamic> json){
    var wechatListJson = json["data"] as List;
    return WeChatResultModel(
      data: wechatListJson == null ? [] : wechatListJson.map((item) => WeChatModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}