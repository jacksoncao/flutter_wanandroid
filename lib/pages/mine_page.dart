import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/widget_utils.dart';
import '../utils/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../model/user/user_model.dart';
import '../dao/user_dao.dart';
import '../model/base_result_model.dart';

class MimePage extends StatefulWidget {
  MimePage({Key key}) : super(key: key);

  _MimePageState createState() => _MimePageState();
}

class _MimePageState extends State<MimePage>
    with AutomaticKeepAliveClientMixin {
  @protected
  bool get wantKeepAlive => true;

  //用户图像组件
  Widget _userAvatar(UserModel user) {
    return Container(
      width: ScreenUtils.width(80),
      height: ScreenUtils.width(80),
      child: CircleAvatar(
        radius: ScreenUtils.width(40),
        backgroundColor: Colors.white,
        backgroundImage: user != null ? NetworkImage(
              "http://pic13.nipic.com/20110409/7119492_114440620000_2.jpg") 
              : AssetImage("images/default_avatar.png"),
      ),
    );
  }

  //注册组件
  Widget _registerWidget() {
    return Container(
        width: ScreenUtils.width(90),
        height: ScreenUtils.width(35),
        margin:EdgeInsets.only(left: ScreenUtils.width(10),),
        child: OutlineButton(
          child:Text("注册",style: TextStyle(fontSize: 14, color: Colors.blue),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: (){
            Navigator.of(context).pushNamed("/register_page");
          },
        )
      );
  }

  //登录组件
  Widget _loginWidget() {
    return Container(
      width: ScreenUtils.width(90),
      height: ScreenUtils.width(35),
      child: OutlineButton(
        child: Text("登录",style: TextStyle(fontSize: 14,color: Colors.blue),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          Navigator.of(context).pushNamed("/login_page");
        },
      ),
    );
  }

  //顶部用户区域的底部组件   未登录：登录/注册按钮  已登录：用户昵称
  Widget _userLoginAndRegisterWidget() {
    return Container(
      margin:EdgeInsets.only(top: ScreenUtils.width(20),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loginWidget(), 
          _registerWidget()
        ],
      ),
    );
  }

  //用户登录昵称显示组件
  Widget _userNicknameWidget(UserModel user){
    return Container(
      child: Text(
        "昵称：${user.nickname}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style:TextStyle(
          fontSize: 13,
          color: Colors.pinkAccent
        ),
      ),
    );
  }

  //用户登录状态显示组件
  Widget _userLoginStatusWidget(){
    return Container(
      margin:EdgeInsets.only(top: ScreenUtils.width(10),),
      child: Text(
        "状态：已登录",
        style:TextStyle(
          color: Colors.blue,
          fontSize:13
        )
      ),
    );
  }

  //登录用户昵称信息组件
  Widget _userInfoWidget(UserModel user){
    return Container(
      padding: EdgeInsets.only(left:ScreenUtils.width(30),right:ScreenUtils.width(30)),
      margin:EdgeInsets.only(top: ScreenUtils.width(20),),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _userNicknameWidget(user),
          _userLoginStatusWidget()
        ],
      ),
    );
  }

  //顶部区域用户相关组件
  Widget _topUserWidget(UserModel user) {
    return Consumer<UserProvider>(
      builder: (context,provider,child){
        return Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: ScreenUtils.width(270),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _userAvatar(user),
              user == null ? _userLoginAndRegisterWidget()
                  : _userInfoWidget(user)
            ],
          ),
        );
      },
    );
  }

  //公众号组件
  Widget _weChatWidget(){
    return Material(
      child: InkWell(
        child: Container(
          alignment:Alignment.center,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.black12))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/wechat.svg',width: ScreenUtils.width(45),height: ScreenUtils.width(45),),
              SizedBox(width: ScreenUtils.width(25),),
              Text("公众号",style: TextStyle(fontSize: 16),)
            ],
          ),
        ),
        onTap: (){
          Navigator.of(context).pushNamed("/wechat_list_page");
        },
      ),
    );
  }

  //收藏组件
  Widget _collectionWidget(UserModel user){
    return Material(
      child: InkWell(
        child: Container(
          alignment:Alignment.center,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.black12))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("assets/collection.svg",width: ScreenUtils.width(45),height: ScreenUtils.width(45),),
              SizedBox(width: ScreenUtils.width(25),),
              Text("我的收藏",style: TextStyle(fontSize: 16),)
            ],
          ),
        ),
        onTap: (){
          if(user == null){
            Navigator.of(context).pushNamed("/login_page");
          }else{
            Navigator.of(context).pushNamed("/collection_page");
          }
        },
      ),
    );
  }

  //中间  公众号和收藏区域组件视图
  Widget _middleButtonsWidget(UserModel user) {
    return Container(
      color: Colors.white,
      height: ScreenUtils.width(80),
      margin:EdgeInsets.only(top: ScreenUtils.width(10),),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _weChatWidget(),
          ),
          Expanded(
            flex: 1,
            child: _collectionWidget(user),
          ),
        ],
      ),
    );
  }

  //底部功能列表组件
  Widget _bottomListWidget(UserModel user) {
    return Container(
      margin:EdgeInsets.only(top: ScreenUtils.width(10),),
      child: Column(
        children: <Widget>[
          ListTileWidget(
            iconName: "assets/settings.svg",
            iconColor: Colors.red,
            title: "系统设置",
            height: ScreenUtils.height(70),
            onTap: (){
              Navigator.of(context).pushNamed("/test_page");
            },
          ),
          Divider(height: 1,),
          ListTileWidget(
            iconName: "assets/todo.svg",
            title: "我的事项",
            height: ScreenUtils.height(70),
            onTap: (){
              if(user == null){
                Navigator.of(context).pushNamed("/login_page");
              }else{
                Navigator.of(context).pushNamed("/todo_page");
              }
            },
          ),
          Divider(height: 1,),
          ListTileWidget(
            iconName: "assets/waps.svg",
            title: "常用网站",
            height: ScreenUtils.height(70),
            onTap: (){
              Navigator.of(context).pushNamed("/wap_list_page");
            },
          ),
          Divider(height:1),
          ListTileWidget(
            iconName: "assets/logout.svg",
            title: "退出登录",
            height: ScreenUtils.height(70),
            onTap: (){
              _logout();
            },
          ),
          Divider(height: 1,),
          ListTileWidget(
            iconName: "assets/open_source.svg",
            title: "开源协议",
            height: ScreenUtils.height(70),
            onTap: (){
              Navigator.of(context).pushNamed("/open_source_page");
            },
          ),
          Divider(height: 1,),
          ListTileWidget(
            iconName: "assets/about.svg",
            title: "关于我们",
            height: ScreenUtils.height(70),
            onTap: (){
              Navigator.of(context).pushNamed("/about_page");
            },
          ),
        ],
      ),
    );
  }

  _logout(){
    UserDao.logout().then((result){
      if(result.resultCode == BaseResultModel.STATE_OK){
        showToast("退出登录成功");
        Provider.of<UserProvider>(context).setLoginUser(null);
      }else{
        showToast("${result.errorMsg}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserProvider>(
      builder: (context,provider,child){
        return Scaffold(
          appBar: commonAppBar("个人中心"),
          backgroundColor: Colors.black12,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _topUserWidget(provider.loginUser),
                  _middleButtonsWidget(provider.loginUser),
                  _bottomListWidget(provider.loginUser)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

typedef VoidFunction = void Function();

//自定义功能列表widget，主要是用于设置/退出/关于
class ListTileWidget extends StatelessWidget {

  final String iconName;
  final Color iconColor;
  final String title;
  final double height;
  final VoidFunction onTap;


  ListTileWidget({this.iconName,this.iconColor,this.title,this.height,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: height,
      child: Material(
        child: InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(ScreenUtils.width(20), ScreenUtils.width(10), ScreenUtils.width(20), ScreenUtils.width(10)),
            child: Row(
              children: <Widget>[
                _iconWidget(),
                SizedBox(width: ScreenUtils.width(20),),
                Expanded(
                  flex: 1,
                  child:_titleWidget(),
                ),
                Icon(Icons.arrow_right,color: Colors.black38,),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  //使用svg
  Widget _iconWidget(){
    return Container(
      width: ScreenUtils.width(30),
      height: ScreenUtils.width(30),
      child: SvgPicture.asset(iconName,color: iconColor,)
    );
  }

  Widget _titleWidget(){
    return Container(
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54
        ),
      ),
    );
  }
}
