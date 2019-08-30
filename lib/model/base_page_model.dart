//分页加载数据的基本model结构，一页数据都要继承这个model，并通过泛型来代表不同的业务数据
class BasePageModel<T>{
  int curPage; //当前的页码
  final List<T> datas; //列表数据集合
  int offset; //当前页面的偏移量
  bool over; // 请求数量是否超过总数据量索引
  int pageCount; // 总的页数
  int size; //每页请求数量
  int total; //总的数据量

  BasePageModel({this.datas,Map<String,dynamic> json}){
      curPage = json["curPage"];
      offset = json["offset"];
      over = json["over"];
      pageCount = json["pageCount"];
      size = json["size"];
      total = json["total"];
  }

}