import '../base_result_model.dart';
import 'search_hotkey_model.dart';

//搜索热词请求结果Model
class SearchHotKeyResultModel extends BaseResultModel<List<SearchHotKeyModel>>{

  SearchHotKeyResultModel({List<SearchHotKeyModel> data,Map<String,dynamic> json})
    :super(data:data,json:json);

  factory SearchHotKeyResultModel.fromJson(Map<String,dynamic> json){
    var searchHotkeyListJson = json["data"] as List;
    return SearchHotKeyResultModel(
      data: searchHotkeyListJson == null ? [] : searchHotkeyListJson.map((item) => SearchHotKeyModel.fromJson(item)).toList(),
      json:json
    );
  }

  @override
  bool hasNoData() {
    return data == null || data.length == 0;
  }

}