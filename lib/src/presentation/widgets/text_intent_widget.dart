import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_recognition_app/src/utils/colors.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/enums.dart';
import 'package:velocity_x/velocity_x.dart';

class TextIntentWidget extends StatelessWidget {
  const TextIntentWidget(
      {super.key, required this.text, required this.textType});
  final String text;
  final TextType textType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: text.text.semiBold.color(black).make(),
      trailing: IconButton(icon: _assignIcon(), onPressed: () {}),
    )
        .centered()
        .box
        .height(CustomMediaQuery.makeHeight(context, .08))
        .shadow
        .color(white)
        .rounded
        .width(CustomMediaQuery.makeWidth(context, .9))
        .makeCentered()
        .py(CustomMediaQuery.makeHeight(context, .01));
  }

  //
  FaIcon _assignIcon() {
    if (textType == TextType.email) {
      return FaIcon(FontAwesomeIcons.mailBulk, color: purple);
    } else if (textType == TextType.number) {
      return FaIcon(FontAwesomeIcons.phone, color: blue);
    } else if (textType == TextType.plainText) {
      return FaIcon(Icons.copy_all_rounded, color: black);
    }

    return FaIcon(FontAwesomeIcons.internetExplorer, color: purple);
  }
}
