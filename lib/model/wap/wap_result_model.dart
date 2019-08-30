import 'wap_model.dart';
import '../base_result_model.dart';

//常用网站接口请求结果model，直接返回所有的数据，没有用到分页返回
class WapResultModel extends BaseResultModel<List<WapModel>>{

  WapResultModel({List<WapModel> data,Map<String,dynamic> json})
      :super(data:data,json:json);

  factory WapResultModel.fromJson(Map<String,dynamic> json){
    var wapListJson = json["data"] as List;
    return WapResultModel(
      data: wapListJson == null ? [] : wapListJson.map((item) => WapModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}