//Todo的数据model
class TodoModel {

  //Todo的类型定义
  static const int TYPE_LIFE = 1;  //生活
  static const int TYPE_WORK = 2;  //工作
  static const int TYPE_SPORT = 3; //运动
  static const int TYPE_STUDY = 4; //学习

  //Todo的优先级定义
  static const int IMPORTANT = 1; //重要
  static const int NORMAL = 2; //一般

  static const int UNCOMPLETE = 0; //未完成
  static const int COMPLETE = 1; //完成

  //配置类别映射
  static const types = {
    TYPE_LIFE:"生活",
    TYPE_WORK:"工作",
    TYPE_SPORT:"运动",
    TYPE_STUDY:"学习",
  };

  //配置重要性映射
  static const priorities = {
    IMPORTANT:"重要",
    NORMAL:"一般"
  };

  //配置状态映射
  static const statuses = {
    UNCOMPLETE:"未完成",
    COMPLETE:"已完成"
  };

  int completeDate;   //todo实际的完成时间(毫秒时间戳)
  String completeDateStr;  //todo实际的完成时间字符串
  String content;   //todo的内容
  int date;  //todo设置的完成时间(毫秒时间戳)
  String dateStr;  //todo设置的完成时间字符串
  int id;   //todo的id
  int priority;  //优先级
  int status;    //todo的状态  0 未完成   1完成
  String title;  //todo的标题
  int type;  //用户类型
  int userId;  //用户id

  TodoModel(
      {this.completeDate,
      this.completeDateStr,
      this.content,
      this.date,
      this.dateStr,
      this.id,
      this.priority,
      this.status,
      this.title,
      this.type,
      this.userId});

  TodoModel.fromJson(Map<String, dynamic> json) {
    completeDate = json['completeDate'];
    completeDateStr = json['completeDateStr'];
    content = json['content'];
    date = json['date'];
    dateStr = json['dateStr'];
    id = json['id'];
    priority = json['priority'];
    status = json['status'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completeDate'] = this.completeDate;
    data['completeDateStr'] = this.completeDateStr;
    data['content'] = this.content;
    data['date'] = this.date;
    data['dateStr'] = this.dateStr;
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }

}