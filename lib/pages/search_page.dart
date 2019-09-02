import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/model/article/article_page_model.dart';
import 'package:flutter_wananzhuo/model/hotkey/search_hotkey_model.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import 'package:flutter_wananzhuo/widget/refresh_widget.dart';
import 'package:flutter_wananzhuo/widget/search_appbar_widget.dart';
import '../dao/search_dao.dart';
import '../utils/screen_util.dart';
import '../model/common/common_model.dart';
import '../widget/article_item_widget.dart';
import 'package:provider/provider.dart';
import '../provider/search_provider.dart';
import '../utils/hotkey_utils.dart';
import 'dart:math';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  StateController _controller = StateController();
  PageType _pageType = PageType.HOTKEY;  
  String _key; //搜索词
  Random mRandom = Random();
  SearchTextChangeNotifier  changeNotifier;
  
  //自定义搜索AppBar
  Widget _searchAppBar(SearchProvider provider){
    return SearchAppBarWidget(
      height: ScreenUtils.width(110),
      textColor: Colors.grey,
      onTap: (value){
        _search(value,provider);
      },
      onReceiveNotifier: (notifier){
        changeNotifier = notifier;
      },
      onValueChanged: (value){  //输入框的内容为空时，显示搜索热词页面
        if((value == null || value.length == 0) && _pageType != PageType.HOTKEY){
          setState(() {
            _key = value;
            _pageType = PageType.HOTKEY; 
          });
        }
      },
    );
  }

  //内容组件
  Widget _contentWidget(SearchProvider provider){
    return Container(
      //留出AppBar的高度，避免遮挡列表内容
      padding: EdgeInsets.only(top: ScreenUtils.width(110)),
      color: Colors.black12,
      child: DynamicLoadingWidget<ArticlePageModel>(
        controller: _controller,
        asyncLoad: () => SearchDao.getArticlesBySearchKey(_key, 0),
        loadedWidget: (data){
          return RefreshWidget<CommonModel>(
            onLoadMore: (index) => SearchDao.getArticlesBySearchKey(_key, index),
            child: ListView.builder(
              itemCount: provider.searchArticles.length,
              itemBuilder: (context,index){
                return ArticleItemWidget(data:provider.searchArticles[index]);
              },
            ),
            onResultData: (data) => provider.addArticleList(data),
          );
        },
        receiveData: (data)=> provider.addArticleList(data.datas),
      ),
    );
  }

  //整个搜索热词显示区域组件
  Widget _hotkeyWidget(SearchProvider provider){
    if(provider.hotkeyList.length == 0){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: ScreenUtils.width(110)),
        child: Text("暂时还没有搜索热词"),
      );
    }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: ScreenUtils.width(110)),
        margin: EdgeInsets.all(ScreenUtils.width(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtils.width(15)),
              child: Text(
                "搜索热词：",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16
                ),
              ),
            ),
            Wrap(
              spacing: ScreenUtils.width(10),
              runSpacing: ScreenUtils.width(10),
              children: provider.hotkeyList.map((model) => _hotkeyItemWidget(context,model,provider)).toList(),
            )
          ],
        ),
      )
    );
  }

  //搜索热词组件
  Widget _hotkeyItemWidget(context,SearchHotKeyModel model,SearchProvider provider){
    return Container(
        height: ScreenUtils.width(50),
        child: FlatButton(
          child: Text("${model.name}",style: TextStyle(color: Colors.white,fontSize: 15),),
          color: Color.fromARGB(255, mRandom.nextInt(255), mRandom.nextInt(255), mRandom.nextInt(255)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: (){
            _search(model.name,provider);  //切换页面，执行搜索操作
            changeNotifier?.changeText(_key); // 点击搜索热词，需要同时改变搜索框中的显示内容
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    SearchProvider provider = Provider.of<SearchProvider>(context);
    HotkeyUtils.requestHotkeyList(provider);
    return Scaffold(
      body: Container(
        width: ScreenUtils.screenWidth,
        //此处使用Stack而没有使用Column，
        //因为Column和ListView嵌套会有问题，需要将ListView的shrinkWrap设置为true,
        //这样ListView的内容有多长ListView就会有多长
        child: Stack(  
          children: <Widget>[
            Offstage(
              offstage: _pageType != PageType.HOTKEY,
              child: _hotkeyWidget(provider),
            ),
            Offstage(
              offstage: _pageType != PageType.SEARCH,
              child: _contentWidget(provider),
            ),
            _searchAppBar(provider),
          ],
        ),
      ),
    );
  }

  //搜索操作，改变当前页面显示为搜索loading，清空搜索结果集合，设置搜索框中的搜索词
  _search(String key,SearchProvider provider){
    setState(() {
      _pageType = PageType.SEARCH;  //显示DynamicLoadingWidget搜索组件
      _key = key;
      provider.clearArticleList();  //清空搜索数据
      _controller.loading();  //将搜索组件的状态改为loading状态，显示加载中进度条
    });
  }
}

enum PageType{

  HOTKEY, //显示搜索热词

  SEARCH, //显示搜索页面

}
