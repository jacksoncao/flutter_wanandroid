import 'package:flutter/material.dart';
import '../utils/widget_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../utils/screen_util.dart';
import '../model/common/common_model.dart';
import '../model/banner/homebanner_model.dart';
import '../model/user/user_model.dart';
import '../dao/collection_dao.dart';
import '../model/base_result_model.dart';

//web详情页(多种类型页面共用)
class DetailPage extends StatefulWidget {

  final Map arguments;

  DetailPage({this.arguments});

  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  PageType type; //文章id
  CommonModel article;  //文章数据，收藏文章
  HomeBannerItemModel bannerItem;  //首页banner
  Map<String,dynamic> wapArgs; //网页数据  id  name  link
  PageState _currentState = PageState.LOADING;
  WebViewController _controller;

  @override
  void initState() { 
    super.initState();
    type = widget.arguments["type"];
    if(type == PageType.INNER_WAP || type == PageType.OUTTER_WAP){
      wapArgs = widget.arguments["data"] as Map;
    }else if(type == PageType.BANNER){
      bannerItem = widget.arguments["data"] as HomeBannerItemModel;
    }else if(type == PageType.ARTICLE || type == PageType.ARTICLE_COLLECT){
      article = widget.arguments["data"] as CommonModel;
    }
  }

  //刷新按钮
  Widget _reloadWidget(){
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left:ScreenUtils.height(30),right:ScreenUtils.width(30)),
        child: Icon(Icons.refresh,color: Colors.white,size: ScreenUtils.width(35), ),
      ),
      onTap: () {
        setState(() {
          _currentState = PageState.LOADING; 
          _controller.reload();  //点击刷新按钮，重新加载url
        });
      },
    );
  }

  //收藏组件
  Widget _collectWidget(){
    return Consumer<UserProvider>(
      builder: (context,provider,child){
        return InkWell(
          child: Container(
            padding: EdgeInsets.only(right:ScreenUtils.width(30)),
            child: Icon(Icons.favorite,
              color: isCollected(provider.loginUser) ?Colors.green : Colors.white,
              size: ScreenUtils.width(35), ),
          ),
          onTap: () => changeFavoriteState(context,provider.loginUser),
        );
      },
    );
  }

  //AppBar上的操作按钮
  List<Widget> _actionWidgets(){
    List<Widget> list = [];
    list.add(_reloadWidget());
    if(type != PageType.BANNER && type != PageType.OUTTER_WAP){
      list.add(_collectWidget());
    }
    return list;
  }

  //点击收藏按钮  收藏文章，网页或者取消收藏
  changeFavoriteState(context,UserModel user){
    if(user == null) showToast("您还没有登录，请先登录");
    if(isCollected(user)){ //已收藏，点击取消收藏
      if(type == PageType.ARTICLE){
        CollectionDao.uncollectArticle(article.id).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(article.id);
          }
        });
      }else if(type == PageType.ARTICLE_COLLECT){
        CollectionDao.uncollectCollectPageArticle(article.id, article.originId).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(article.originId);
          }
        });
      }else if(type == PageType.INNER_WAP){
        CollectionDao.uncollectWap(wapArgs["id"]).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(wapArgs["id"]);
          }
        });
      }
    }else{
      if(type == PageType.ARTICLE || type == PageType.ARTICLE_COLLECT){
        CollectionDao.collectArticle(type == PageType.ARTICLE ? article.id : article.originId).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("收藏成功");
            Provider.of<UserProvider>(context).addCollectionId(type == PageType.ARTICLE ? article.id : article.originId);
          }
        });
      }else if(type == PageType.INNER_WAP){
        CollectionDao.collectWap(wapArgs["name"],wapArgs["link"]).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(wapArgs["id"]);
          }
        });
      }
    }
  }

  //是否已经被收藏了
  bool isCollected(UserModel user){
    if(user == null || user.collectIds == null || user.collectIds.length == 0){
      return false;
    }
    if(type == PageType.INNER_WAP){
      return user.collectIds.contains(wapArgs["id"]);
    }else if(type == PageType.ARTICLE){
      return user.collectIds.contains(article.id);
    }else{
      return user.collectIds.contains(article.originId);
    }
  }

  //网页的url地址
  String _getUrl(){
    String url = "";
    if(type == PageType.INNER_WAP){  // id  name  link
      url = wapArgs["link"];
    }else if(type == PageType.BANNER){
      url = bannerItem.url;
    }else if(type == PageType.ARTICLE || type == PageType.ARTICLE_COLLECT){
      url = article.link;
    }else if(type == PageType.OUTTER_WAP){
      url = wapArgs["url"];
    }
    return url;
  }

  //WebView组件
  Widget _webviewWidget(){
    return Offstage(
      offstage: _currentState != PageState.LOADED,
      child: WebView(
        initialUrl: _getUrl(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          _controller = controller;
        },
        onPageFinished: (url){
          setState(() {
            _currentState = PageState.LOADED; 
          });
        },
      ),
    );
  }

  //加载中loading组件
  Widget _loadingWidget(){
    return Offstage(
      offstage: _currentState != PageState.LOADING,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height:ScreenUtils.width(10)),
            Text(
              "拼命加载中...",
              style:TextStyle(
                fontSize:13,
                color:Colors.pinkAccent
              )
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        "WebView详情页",
        centerTitle:false,
        actions: _actionWidgets()),
      body: Stack(
        children: <Widget>[
          _webviewWidget(),
          _loadingWidget(),
        ],
      ),
    );
  }
}


enum PageType{

  BANNER, //首页banner运营页

  INNER_WAP,  //站内接口返回的普通网页,有id  name  link

  OUTTER_WAP, //直接跳转到站外网页,只有url

  ARTICLE,  //列表文章

  ARTICLE_COLLECT  //收藏的文章

}

enum PageState{

  LOADING,  //加载中

  LOADED,  //加载完成

}