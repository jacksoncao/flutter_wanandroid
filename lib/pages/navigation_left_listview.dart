import 'package:flutter/material.dart';
import '../model/navigation/navigation_category_model.dart';
import 'package:provider/provider.dart';
import '../provider/navigation_provider.dart';
import '../utils/screen_util.dart';

class NavigationLeftListView extends StatelessWidget {
  
  final double width;

  NavigationLeftListView({this.width});

  Widget _listItem(context,NavigationCategoryModel model,index){
    NavigationProvider provider = Provider.of<NavigationProvider>(context);
    return Container(
      height: ScreenUtils.width(60),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey)),
      ),
      child: Material( //点击有水波纹效果
        color: provider.selectedIndex == index ? Colors.black12 : Colors.white,
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "${model.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: provider.selectedIndex == index ? Colors.red : Colors.black,
                fontSize: 14
              ),
            ),
          ),
          onTap: () => provider.selectIndex(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context,provider,child){
        return Container(
          width: width,
          child: ListView.builder(
            itemCount: provider.naviList.length,
            itemBuilder: (context,index){
              return _listItem(context,provider.naviList[index], index);
            }
          ),
        );
      },
    );
  }
}