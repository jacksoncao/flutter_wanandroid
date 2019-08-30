import 'homebanner_model.dart';
import '../base_result_model.dart';

//请求首页banner数据，请求响应结果model
class HomeBannerResultModel extends BaseResultModel<List<HomeBannerItemModel>>{

  HomeBannerResultModel({List<HomeBannerItemModel> data,Map<String,dynamic> json})
      : super(data:data, json:json);

  factory HomeBannerResultModel.fromJson(Map<String,dynamic> json){
    var bannerListJson = json["data"] as List;
    return HomeBannerResultModel(
      data:bannerListJson == null ? [] : bannerListJson.map((item) => HomeBannerItemModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}