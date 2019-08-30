import '../model/navigation/navigation_category_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';

//导航相关页面数据
class NavigationPageDao {

  //得到导航一级分类数据集合,一级分类中包含了二级分类数据
  static Future<NavigationCategoryResultModel> getNavigationCategroyList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.NAVIGATION);
    return NavigationCategoryResultModel.fromJson(json);
  }

}