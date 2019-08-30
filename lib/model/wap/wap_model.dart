//常用网站
class WapModel{
  final String icon;
  final int id;
  final String link;
  final String name;
  final int order;
  final int visible;

  WapModel({this.icon,this.id,this.link,this.name,this.order,this.visible});

  factory WapModel.fromJson(Map<String,dynamic> json){
    return WapModel(
      icon: json["icon"],
      id: json["id"],
      link:json["link"],
      name:json["name"],
      order: json["order"],
      visible:json["visible"]
    );
  }

}