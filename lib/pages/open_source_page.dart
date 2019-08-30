import 'package:flutter/material.dart';
import 'package:flutter_wananzhuo/utils/widget_utils.dart';
import '../data/data.dart';
import '../utils/screen_util.dart';

class OpenSourceListPage extends StatelessWidget {

  const OpenSourceListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("感谢以下开源库作者",centerTitle: false),
      body: Container(
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(left: ScreenUtils.width(8),right: ScreenUtils.width(8)),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Text(
                  "$index",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red
                  )
                ),
                title: Text(
                  datas[index]["name"],
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18
                  ),
                ),
                subtitle: Text(
                  datas[index]["url"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}