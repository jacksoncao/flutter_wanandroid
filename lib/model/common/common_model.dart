
//文章数据model，使用在：所有的文章列表item，导航中tab页中的二级分类item
class CommonModel{
  final String apkLink; //apk的下载地址
  final String author; //作者
  final int chapterId; //文章所属二级分类id
  final String chapterName; //文章所属二级分类名称
  final bool collect;//
  final int courseId; //
  final String desc;// 内容简介
  final String envelopePic; //文章大图
  final bool fresh;//是否是新文章
  final int id; //文章id
  final String link; //文章url地址
  final String niceDate;// 发布时间
  final String origin;//
  final int originId; //在收藏页面中这个字段代表文章id
  final String prefix;//
  final String projectLink;//
  final int publishTime; //发布时间
  final int superChapterId;  //一级分类的第一个子tab的id
  final String superChapterName; //一级分类名称
  final List<TagModel> tags;  //
  final String title; //文章标题
  final int type; //文章类型
  final int userId; 
  final int visible;
  final int zan; //点赞数量
  final bool top; //是否置顶默认false

  CommonModel({this.apkLink,this.author,this.chapterId,
      this.chapterName,this.collect,this.courseId,this.desc,
      this.envelopePic,this.fresh,this.id,this.link,this.niceDate,
      this.origin,this.prefix,this.projectLink,this.publishTime,
      this.superChapterId,this.superChapterName,this.tags,this.title,
      this.type,this.userId,this.visible,this.zan,this.top,this.originId});

  factory CommonModel.fromJson(Map<String,dynamic> json){
    var tagsJson = json["tags"] as List;
    return CommonModel(
      apkLink: json["apkLink"],
      author: json["author"],
      chapterId: json["chapterId"],
      chapterName: json["chapterName"],
      collect: json["collect"],
      courseId: json["courseId"],
      desc: json["desc"],
      envelopePic: json["envelopePic"],
      fresh: json["fresh"] == null ? false : json["fresh"], //在我的收藏列表中没有返回这个字段
      id: json["id"],
      link: json["link"],
      niceDate: json["niceDate"],
      origin: json["origin"],
      prefix: json["prefix"],
      projectLink: json["projectLink"],
      publishTime: json["publishTime"],
      superChapterId: json["superChapterId"],
      superChapterName: json["superChapterName"],
      tags: tagsJson == null ? [] : tagsJson.map((item) => TagModel.fromJson(item)).toList(),
      title: json["title"],
      type: json["type"],
      userId: json["userId"],
      visible: json["visible"],
      zan: json["zan"],
      originId: json["originId"]
    );
  }
}

//文章数据中的tag标签model
class TagModel{
  final String name; //标签名称
  final String url; //该标签接口url地址

  TagModel({this.name,this.url});

  factory TagModel.fromJson(Map<String,dynamic> json){
    return TagModel(
      name: json["name"],
      url: json["url"]
    );
  }
}