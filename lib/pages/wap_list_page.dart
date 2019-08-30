import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/widget/dynamic_loading_widget.dart';
import '../utils/widget_utils.dart';
import '../dao/wap_page_dao.dart';
import '../model/wap/wap_model.dart';
import '../utils/screen_util.dart';
import 'detail_page.dart';

//网站列表页面
class WapListPage extends StatelessWidget {

  const WapListPage({Key key}) : super(key: key);

  //网站列表组件
  Widget _wapListWidget(context,List<WapModel> wapList){
    return ListView.builder(
      itemCount: wapList.length,
      padding: EdgeInsets.only(left:ScreenUtils.width(10),right:ScreenUtils.width(10),bottom: ScreenUtils.width(10) ),
      itemBuilder: (context,index){
        return _wapItemWidget(context,wapList[index]);
      },
    );
  }

  Widget _wapItemWidget(context,WapModel wapModel){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtils.width(10)),
      child:Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: ListTile(
          title: Text(
            "${wapModel.name}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: Icon(Icons.arrow_right,size:ScreenUtils.width(30),color:Colors.black12),
          onTap: (){
            Navigator.of(context).pushNamed("/detail_page",
                arguments: {"data":{"id":wapModel.id,"name":wapModel.name,"link":wapModel.link},"type":PageType.WAP});
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("常用网站",centerTitle: false),
      body: Container(
        alignment:Alignment.center,
        color: Colors.black12,
        child: DynamicLoadingWidget<List<WapModel>>(
          asyncLoad: () => WapDao.getWapList(),
          loadedWidget: (data){
            return _wapListWidget(context, data);
          },
        ),
      ),
    );
  }
}