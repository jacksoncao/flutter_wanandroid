import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wananzhuo/model/article/article_page_model.dart';
import 'package:flutter_wananzhuo/utils/hotkey_utils.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import 'package:flutter_wananzhuo/widget/refresh_widget.dart';
import 'package:flutter_wananzhuo/widget/scroll_opacity_appbar.dart';
import 'detail_page.dart';
import '../dao/home_page_dao.dart';
import '../utils/screen_util.dart';
import '../widget/article_item_widget.dart';
import '../provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../model/base_result_model.dart';
import '../utils/widget_utils.dart';
import '../model/common/common_model.dart';
import '../dao/user_dao.dart';
import '../provider/user_provider.dart';
import '../provider/search_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {

  //轮播图组件
  Widget _swiper() {
    return Consumer<HomeProvider>(
      builder: (context,provider,child){
        return Container(
          height: ScreenUtils.width(280),
          child: Swiper(
            itemCount: provider.bannerList.length,
            autoplay: true,
            pagination: SwiperPagination(),
            itemBuilder: (context, index) {
              return Image.network(
                "${provider.bannerList[index].imagePath}",
                fit: BoxFit.cover,
              );
            },
            onTap: (index) {
              Navigator.of(context).pushNamed("/detail_page",
                  arguments:{"type":PageType.BANNER,"data":provider.bannerList[index]});
            },
          )
        );
      },
    );
  }

  //内容列表组件
  Widget _contentWidget(){
    return Consumer<HomeProvider>(
      builder: (context,provider,child){
        return DynamicLoadingWidget<ArticlePageModel>(
          asyncLoad: () => HomePageDao.getHomeArticleList(0),
          receiveData: (data) => Provider.of<HomeProvider>(context).addHomePageArticle(data.datas),
          loadedWidget: (datas){
            return RefreshWidget<CommonModel>(
              child: ListView.builder(
                itemCount: provider.articleList.length+1,
                itemBuilder: (context, index) {
                  if (index == 0) { //第0个位置固定为轮播图组件
                    return _swiper();
                  } else {
                    return ArticleItemWidget(data:provider.articleList[index - 1]);
                  }
                },
              ),
              onLoadMore: (index) => HomePageDao.getHomeArticleList(index),
              onResultData: (datas) => Provider.of<HomeProvider>(context).addHomePageArticle(datas),
            );
          },
        );
      },
    );
  }

  //保存页面的状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _requestHomeBanner();
    _requestTopArticlesList();
  }

  bool inited = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(!inited){
      inited = true;
      ScreenUtils.init(context);
      UserDao.loadStorageLoginUser(Provider.of<UserProvider>(context));
    }
    HotkeyUtils.requestHotkeyList(Provider.of<SearchProvider>(context));
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ScrollOpacityAppBar(
        appBar: homeAppBar(context,"搜索一下试试吧!"),
        child: _contentWidget(),
      ),
    );
  }

  //请求服务端首页banner数据
  void _requestHomeBanner(){
    HomePageDao.getHomeBannerList().then((model) {
      if(model.resultCode == BaseResultModel.STATE_OK){
        Provider.of<HomeProvider>(context).addHomeBannerList(model.data);
      }
    });
  }

  //置顶文章
  void _requestTopArticlesList(){
    HomePageDao.getTopArticleList().then((model){
      if(model.resultCode == BaseResultModel.STATE_OK){
        Provider.of<HomeProvider>(context).insertTopArticle(model.data);
      }else{
        showToast("没有置顶文章");
      }
    });
  }

}
