
//公众号数据model，数据结构和知识体系分类一样
class WeChatModel{
  final int courseId;
  final int id;
  final String name;
  final int order;
  final int parentChapterId;
  final bool userControlSetTop;
  final int visible;

  WeChatModel({this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible});

  factory WeChatModel.fromJson(Map<String,dynamic> json){
    return WeChatModel(
      courseId:json["courseId"],
      id:json["id"],
      name:json["name"],
      order:json["order"],
      parentChapterId:json["parentChapterId"],
      userControlSetTop:json["userControlSetTop"],
      visible:json["visible"]
    );
  }

}