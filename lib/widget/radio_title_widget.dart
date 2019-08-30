import 'package:flutter/material.dart';
import '../utils/screen_util.dart';

class RadioTitleWidget<T> extends StatefulWidget {
  
  final String title;
  final double fontSize;
  final Color titleColor;
  final Color radioColor;
  final T value;
  final T groupValue;
  final OnCheck<T> onCheck;

  RadioTitleWidget({this.title,
      this.fontSize=15,
      this.titleColor=Colors.grey,
      this.radioColor=Colors.pinkAccent,
      this.value,
      this.groupValue,
      this.onCheck});

  _RadioTitleWidgetState<T> createState() => _RadioTitleWidgetState();
}

typedef  OnCheck<T> = void Function(T value);

class _RadioTitleWidgetState<T> extends State<RadioTitleWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(ScreenUtils.width(8)),
       child: Row(
         children: <Widget>[
           Text(
             widget.title,
             style: TextStyle(
               fontSize: widget.fontSize,
               color: widget.titleColor
             ),
           ),
           Container(  //控制Radio的大小
             height: ScreenUtils.width(35),
             width: ScreenUtils.width(35),
             child: Radio<T>(
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: (t){
                widget.onCheck(t);
              },
            ),
           )
         ],
       ),
    );
  }
}