import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import '../utils/screen_util.dart';
import '../dao/user_dao.dart';
import '../model/base_result_model.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _userName; //用户名
  String _password; //密码

  Widget _usernameWidget(){
    return Container(
      height:ScreenUtils.width(60),
      child: TextField(
        decoration: InputDecoration(
          labelText: "用户名：",
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 14
        ),
        textInputAction: TextInputAction.next,
        onChanged: (value){
          _userName = value;
        },
      ),
    );
  }

  Widget _passwordWidget(){
    return Container(
      height: ScreenUtils.width(60),
      margin: EdgeInsets.only(top: ScreenUtils.width(20)),
      child: TextField(
        decoration: InputDecoration(
          labelText: "密码：",
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 14
        ),
        textInputAction: TextInputAction.done,
        onChanged: (value){
          _password = value;
        },
      ),
    );
  }

  Widget _loginWidget(){
    return Container(
      height: ScreenUtils.width(60),
      margin: EdgeInsets.only(top: ScreenUtils.width(20)),
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          "登录",
          style:TextStyle(
            color:Colors.white,
            fontSize:18
          )
        ),
        color: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: (){
          _login();
        },
      ),
    );
  }

  //登录
  _login(){
    if(_userName != null && _userName.length != 0 
          && _password != null && _password.length != 0){
      UserDao.login(_userName,_password)
        .then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("登录成功!");
            Provider.of<UserProvider>(context).setLoginUser(result.data);
            Navigator.of(context).pop();
            return;
          }
          showToast("${result.errorMsg}");
          return;
        });
        return;
    }
    showToast("用户名和密码均不能为空");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("用户登录",centerTitle:false),
      body: Container(
        padding: EdgeInsets.all(ScreenUtils.width(20)),
        child: Column(
          children: <Widget>[
            _usernameWidget(),
            _passwordWidget(),
            _loginWidget()
          ],
        ),
      ),
    );
  }
}
