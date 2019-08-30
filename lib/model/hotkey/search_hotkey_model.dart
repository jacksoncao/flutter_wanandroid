//搜索热词Model
class SearchHotKeyModel{
  final int id;
  final String link;
  final String name;
  final int order;
  final int visible;

  SearchHotKeyModel({this.id,this.link,this.name,this.order,this.visible});

  factory SearchHotKeyModel.fromJson(Map<String,dynamic> json){
    return SearchHotKeyModel(
      id: json["id"],
      link: json["link"],
      name:json["name"],
      order: json["order"],
      visible: json["visible"]
    );
  }
}