import 'package:flutter/material.dart';
import '../widget/dynamic_loading_widget.dart';
import '../utils/widget_utils.dart';
import '../dao/wechat_dao.dart';
import '../model/wechat/wechat_model.dart';
import '../utils/screen_util.dart';

//微信公众号列表页面
class WeChatListPage extends StatelessWidget {

  const WeChatListPage({Key key}) : super(key: key);

 Widget _wechatItemWidget(context,WeChatModel wechatModel){
    return Container(
      padding: EdgeInsets.only(top: ScreenUtils.width(10)),
      height: ScreenUtils.width(90),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: ListTile(
          title: Text(
            "${wechatModel.name}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.green
            ),
          ),
          trailing: Icon(Icons.arrow_right,size: ScreenUtils.width(30),color: Colors.grey,),
          onTap: (){
            Navigator.of(context).pushNamed("/wechat_articles_page",arguments:wechatModel);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("公众号列表",centerTitle:false),
      body: Container(
        color: Colors.black12,
        child: DynamicLoadingWidget<List<WeChatModel>>(
          asyncLoad: () => WeChatDao.getWeChatList(),
          loadedWidget: (data){
            return ListView.builder(
              padding: EdgeInsets.all(ScreenUtils.width(10)),
              itemCount: data.length,
              itemBuilder: (context,index){
                return _wechatItemWidget(context,data[index]);
              },
            );
          },
        ),
      )
    );
  }

}
