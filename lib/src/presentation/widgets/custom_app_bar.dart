import 'package:flutter/material.dart';
import 'package:text_recognition_app/src/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

VxAppBar customAppBar(BuildContext context, String title,
    {bool isSubPage = false}) {
  return VxAppBar(
    backgroundColor: Colors.transparent,
    elevation: .0,
    leading: isSubPage
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    title: title.text
        .fontFamily('Block')
        .italic
        .light
        .underline
        .color(purple)
        .headline5(context)
        .make(),
  );
}
