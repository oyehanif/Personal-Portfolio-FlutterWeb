import 'package:flutter/material.dart';
import 'package:oyehanif/globles/app_text_style.dart';

class MyText extends StatelessWidget {
  MyText(this.text,{super.key , this.style});

  String text;
  TextStyle? style = AppTextStyles.headerTextStyle();

  @override
  Widget build(BuildContext context) {
    return Text(text,style: style,);
  }
}
