import 'package:flutter/material.dart';

//滑动改变透明度的appbar组件
class ScrollOpacityAppBar extends StatefulWidget {
  final Widget child; //滚动View组件
  final Widget appBar; //appBar组件
  final bool translucent; //是否扩展到状态栏显示
  final double opacityDistance; //从全透明到不透明的滑动距离
  final double initOpacity; //appBar的起始透明度

  ScrollOpacityAppBar(
      {this.child,
      this.appBar,
      this.translucent = false,
      this.opacityDistance = 100,
      this.initOpacity=0});

  _ScrollOpacityAppBarState createState() => _ScrollOpacityAppBarState();
}

class _ScrollOpacityAppBarState extends State<ScrollOpacityAppBar> {

  double _opacity ; //appBar的当前显示透明度值

  @override
  void initState() { 
    super.initState();
    _opacity = widget.initOpacity;
  }

  //底部内容Widget
  Widget _contentWidget() {
    if (widget.translucent) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _scrollNotificationWidget(),
      );
    }
    return _scrollNotificationWidget();
  }

  //滑动监听Widget，通过监听滑动不断改变appBar的透明度
  Widget _scrollNotificationWidget() {
    return NotificationListener(
      child: widget.child,
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification && notification.depth == 0) {
          double deltaOpacity = (notification.metrics.pixels 
                  / widget.opacityDistance)*(1-widget.initOpacity);
          double opacity = widget.initOpacity + deltaOpacity;
          if (opacity < 0) {
            opacity = 0;
          } else if (opacity > 1) {
            opacity = 1;
          }
          setState(() {
            _opacity = opacity;
          });
        }
      },
    );
  }

  //appBar组件
  Widget _appBarWidget() {
    return Opacity(
        opacity: _opacity,
        child: Container(
          child: widget.appBar,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _contentWidget(),
           _appBarWidget()
        ],
      ),
    );
  }
}
