import '../model/article/article_page_result_model.dart';
import '../model/project/project_category_result_model.dart';
import '../utils/net_utils.dart';
import '../api/api.dart';

//相关相关页面数据
class ProgramPageDao{

  //获取项目(项目本身是一个一级分类)的分类数据集合，这些二级分类数据在顶部滑动Tab中显示
  static Future<ProjectCategoryResultModel> getProgramCategoryList() async{
    Map<String,dynamic> json = await NetUtils.get(Api.PROJECT_CATEGORY);
    return ProjectCategoryResultModel.fromJson(json);
  }

  //根据项目中的某个二级分类id和当前页面pageIndex，请求一页文章数据，项目页码从第1页开始
  static Future<ArticlePageResultModel> getArticleListByCidAndPageIndex(int pageIndex,int cid) async{
    Map<String,dynamic> json = await NetUtils.get(Api.PROJECT_CATRGORY_ARTICLES + "$pageIndex/json?cid=$cid");
    return ArticlePageResultModel.fromJson(json);
  }

}