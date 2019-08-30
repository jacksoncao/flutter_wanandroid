import 'package:flutter/material.dart';
import '../utils/widget_utils.dart';
import '../utils/screen_util.dart';
import '../dao/user_dao.dart';
import '../model/base_result_model.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String _username;
  String _password;
  String _repassword;

  //用户名组件
  Widget _usernameWidget(){
    return Container(
      height: ScreenUtils.width(60),
      child: TextField(
        decoration: InputDecoration(
          labelText: "用户名：",
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 14,
        ),
        onChanged: (value){
          _username = value;
          print("$_username");
        },
      ),
    );
  }

  //密码组件
  Widget _passwordWidget(){
    return Container(
      height: ScreenUtils.width(60),
      margin: EdgeInsets.only(top: ScreenUtils.width(20)),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "密码：",
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 14
        ),
        onChanged: (value){
          _password = value;
          print("$_password");
        },
      ),
    );
  }

  //确认密码组件
  Widget _rePasswordWidget(){
    return Container(
      height: ScreenUtils.width(60),
      margin: EdgeInsets.only(top: ScreenUtils.width(20)),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "确认密码：",
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 14
        ),
        onChanged: (value){
          _repassword = value;
          print("$_repassword");
        },
      ),
    );
  }

  //注册按钮组件
  Widget _registerWidget(){
    return Container(
      height: ScreenUtils.width(50),
      margin: EdgeInsets.only(top: ScreenUtils.width(20)),
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          "注册",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
        ),
        color: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: (){
          _registerUser();
        },
      ),
    );
  }

  _registerUser(){
    //检查输入用户名/密码/确认密码都不能为空
    if(_username != null && _password != null && _repassword != null
        && _username.length != 0 && _password.length != 0 && _repassword.length != 0){
      //检查密码和确认密码要一致才能进行注册
      if(_password == _repassword){
        UserDao.registerUser(_username,_password,_repassword)
        .then((result){
          if(result.resultCode == BaseResultModel.STATE_OK){
            showToast("注册成功!");
            Provider.of<UserProvider>(context).setLoginUser(result.data);
            Navigator.of(context).pop();
            return;
          }
          showToast("注册失败:${result.errorMsg}!");
        });
        return;
      }
      showToast("两次输入的密码不一致，请检查!");
      return;
    }
    showToast("用户名和密码不能为空");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar("用户注册",centerTitle: false),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(ScreenUtils.width(20)),
          child: Column(
            children: <Widget>[
              _usernameWidget(),
              _passwordWidget(),
              _rePasswordWidget(),
              _registerWidget()
            ],
          ),
        ),
      ),
    );
  }
}
