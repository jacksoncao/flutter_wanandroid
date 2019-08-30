
//首页顶部轮播图数据model
class HomeBannerItemModel{
  final String desc; //banner描述内容
  final int id;  //banner的id
  final String imagePath;  //banner的图片地址
  final int isVisible; //banner是否展示
  final int order;  // banner的序号
  final String title;  //banner的标题
  final int type;  //banner的类型
  final String url; //点击跳转页面url地址

  HomeBannerItemModel({this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url});

  factory HomeBannerItemModel.fromJson(Map<String,dynamic> json){
    return HomeBannerItemModel(
      desc: json["desc"],
      id: json["id"],
      imagePath: json["imagePath"],
      isVisible: json["isVisible"],
      order: json["order"],
      title: json["title"],
      type: json["type"],
      url: json["url"]
    );
  }
}