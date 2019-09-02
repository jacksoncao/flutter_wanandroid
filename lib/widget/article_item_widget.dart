import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import '../model/common/common_model.dart';
import '../utils/screen_util.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../model/user/user_model.dart';
import '../dao/collection_dao.dart';
import '../model/base_result_model.dart';
import '../pages/detail_page.dart';
import '../utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser; //命名别名，解决类名重名问题

//自定义文章列表item组件，目前可以在  首页列表/项目分类下的列表 复用
class ArticleItemWidget extends StatelessWidget {

  final CommonModel data;

  final Type itemType;

  ArticleItemWidget({this.data, this.itemType = Type.COMMON_LIST});

  //自定义底部文本组件
  Widget _simpleTextWidget(String title,
      {Color textColor = Colors.grey,
      double fontSize = 12,
      double padding = 3}) {
    return Container(
      padding: EdgeInsets.all(ScreenUtils.width(padding)),
      child: Text("$title",
          style: TextStyle(color: textColor, fontSize: fontSize)),
    );
  }

  //文章作者以及发布时间组件
  Widget _articleAuthorAndDate(CommonModel item) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(3)),
      child: Row(
        children: <Widget>[
          _simpleTextWidget("作者：${item.author}"),
          _simpleTextWidget("发布时间：${item.niceDate}")
        ],
      ),
    );
  }

  //标签组件
  Widget _tagWidget(String tagName, {Color borderColor, Color tagColor}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtils.width(2)),
          border: Border.all(color: borderColor, width: 1)),
      child: _simpleTextWidget("$tagName", textColor: tagColor, padding: 0),
    );
  }

  //底部分类信息区域
  Widget _articleBottomTagAndCategory(CommonModel item) {
    return Container(
      child: Row(
        children: _bottomWidgetList(item),
      ),
    );
  }

  //底部标签及文字组件集合
  List<Widget> _bottomWidgetList(CommonModel article) {
    List<Widget> list = [];
    if (article.fresh) {
      //显示新标签
      list.add(_tagWidget("新", borderColor: Colors.red, tagColor: Colors.red));
      list.add(SizedBox(width: ScreenUtils.width(5)));
    }
    String superChapterName =
        article.superChapterName == null ? "" : article.superChapterName + "/";
    if (article.tags != null && article.tags.length > 0) {
      // 显示tag标签
      list.add(_tagWidget(article.tags[0].name,
          borderColor: Colors.blue, tagColor: Colors.blue));
      list.add(SizedBox(width: ScreenUtils.width(5)));
      list.add(_simpleTextWidget("$superChapterName${article.chapterName}"));
    } else {
      list.add(_simpleTextWidget("分类：$superChapterName${article.chapterName}"));
    }
    list.add(_favoriteWidget(article));
    return list;
  }

  Widget _favoriteWidget(CommonModel article) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(
                      left: ScreenUtils.width(20), right: ScreenUtils.width(10)),
                  child: isCollected(provider.loginUser, article)
                    ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: ScreenUtils.width(30),
                    )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.black12,
                        size: ScreenUtils.width(30),
                    ),
                ),
                onTap: () {
                  changeFavoriteStatus(context, provider.loginUser, article);
                },
              ),
            )
        );
      }
    );
  }

  bool isCollected(UserModel user, CommonModel article) {
    if (user == null ||
        user.collectIds == null ||
        user.collectIds.length == 0) {
      return false;
    }
    return user.collectIds
        .contains(itemType == Type.COMMON_LIST ? article.id : article.originId);
  }

  //改变文章的收藏状态
  changeFavoriteStatus(context, UserModel user, CommonModel article) {
    if(user == null) showToast("您还没有登录，请登录后在操作");
    if(isCollected(user,article)){ //已收藏，点击取消收藏
      if(itemType == Type.COMMON_LIST){
        CollectionDao.uncollectArticle(article.id).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(article.id);
          }
        });
      }else if(itemType == Type.COLLECT_LIST){
        CollectionDao.uncollectCollectPageArticle(article.id, article.originId).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("取消收藏成功");
            Provider.of<UserProvider>(context).removeCollectionId(article.originId);
          }
        });
      }
    }else{
      CollectionDao.collectArticle(itemType == Type.COMMON_LIST ? article.id : article.originId).then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("收藏成功");
            Provider.of<UserProvider>(context).addCollectionId(itemType == Type.COMMON_LIST ? article.id : article.originId);
          }
        }
      );
    }
  }

  //文章标题组件
  Widget _articleTitleWidget() {
    /**
     * 接口返回的标题中，含有中含有html标签，为了解析html标签及自定义显示样式，做了一下取舍：
     *    1.为了解析html元素，没有直接使用Text组件
     *    2.因为html元素内容不固定，使用RichText不能灵活的自定义显示样式
     *    3.
     */
    return Container(
      child: RichText(
        text: TextSpan(
          children: _parseArticleTitleSpans(data.title)
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1, //设置为单行
      ),
    );
  }

  //使用html解析器解析标题的内容
  List<TextSpan> _parseArticleTitleSpans(String title){
     dom.Document document = parser.parse(data.title);
     dom.Node node = document.body;
     return node.nodes.map((i) => _parseNode(i)).toList();
  }

  //解析html中的node元素，返回TextSpan
  TextSpan _parseNode(dom.Node node){
    if(node is dom.Element){
      switch(node.localName){
          case "em":
            return TextSpan(text:node.text,style: TextStyle(color: Colors.pinkAccent,fontSize: 17),);
        }
     }
    String finalText = node.text.replaceAll("\n", "").trim();
    return TextSpan(text:finalText,style: TextStyle(color: Colors.black,fontSize: 17),);
  }

  //文章内容简介组件
  Widget _articleDescriptionWidget() {
    return Container(
      child: Text(
        "${data.desc}",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }

  //右侧内容视图
  Widget _rightWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _articleTitleWidget(),
        _articleDescriptionWidget(),
        _articleAuthorAndDate(data),
        _articleBottomTagAndCategory(data)
      ],
    );
  }

  //真个item视图组件，包含：左侧图片和右侧内容视图
  Widget _itemContentWidget(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: ScreenUtils.width(5)),
          width: ScreenUtils.width(80),
          height: ScreenUtils.width(120),
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: data.envelopePic,
            placeholder: (context,url) => CircularProgressIndicator(backgroundColor: Colors.grey,),
            errorWidget: (context,url,error) => Icon(Icons.error_outline,size: ScreenUtils.width(35),color: Colors.pinkAccent,),
          ),
        ),
        Expanded(
          flex: 1,
          child: _rightWidget(),
        )
      ],
    );
  }

  bool get _hasImage => data.envelopePic != null && data.envelopePic.length > 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //设置margin是为了列表item的上左右三个方向都有10的距离
      margin: EdgeInsets.fromLTRB(ScreenUtils.width(10), ScreenUtils.width(10),
          ScreenUtils.width(10), 0),
      child: Material(//使用这个是为了点击有水波纹效果
        //设置列表item为圆角
        borderRadius: BorderRadius.circular(ScreenUtils.width(5)),
        //设置列表item的背景色为白色
        color: Colors.white,
        child: InkWell(
          //使用这个可以增加点击事件
          child: Container(
            //列表item的内容显示区域距离列表item的边框有12的距离
            padding: EdgeInsets.all(ScreenUtils.width(12)),
            child: _hasImage ? _itemContentWidget():_rightWidget(),
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/detail_page", 
                arguments: {"type":itemType == Type.COMMON_LIST ? PageType.ARTICLE : PageType.ARTICLE_COLLECT,"data":data});
          },
        ),
      ),
    );
  }
}

enum Type {

  COMMON_LIST, //通用文章列表样式

  COLLECT_LIST, //收藏页面文章列表

}
