//用户信息model
class UserModel {
  bool admin;  //当前用户是否是admin管理员
  // List<int> chapterTops;
  List<int> collectIds;  //收藏文章的id
  String email; //用户邮箱
  String icon;  //用户图像
  int id;  //用户id
  String nickname;  //用户昵称
  String password;  //用户密码
  String token;
  int type;  //用户类型
  String username; //用户名

  UserModel({this.admin,
      this.email,this.icon,this.id,this.nickname,this.password,
      this.token,this.type,this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    // if (json['chapterTops'] != null) {
    //   chapterTops = new List<int>();
    //   json['chapterTops'].forEach((v) {
    //     chapterTops.add(new Null.fromJson(v));
    //   });
    // }
    if (json['collectIds'] != null) {
      collectIds = [];
      json['collectIds'].forEach((v) {
        collectIds.add(v);
      });
    }
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    // if (this.chapterTops != null) {
    //   data['chapterTops'] = this.chapterTops.map((v) => v.toJson()).toList();
    // }
    if (this.collectIds != null) {
      data['collectIds'] = this.collectIds.toList();
    }
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    return data;
  }
}