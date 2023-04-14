import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_recognition_app/src/utils/colors.dart';
import 'package:text_recognition_app/src/utils/custom_loading.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/enums.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
      trailing: IconButton(
          icon: _assignIcon(), onPressed: () => _openIntent(context)),
    )
        .centered()
        .box
        .height(CustomMediaQuery.makeHeight(context, .08))
        .shadow
        .color(white)
        .roundedSM
        .width(CustomMediaQuery.makeWidth(context, .9))
        .makeCentered()
        .py(CustomMediaQuery.makeHeight(context, .01));
  }

  //
  FaIcon _assignIcon() {
    if (textType == TextType.email) {
      // ignore: deprecated_member_use
      return FaIcon(FontAwesomeIcons.mailBulk, color: purple);
    } else if (textType == TextType.number) {
      return FaIcon(FontAwesomeIcons.phone, color: blue);
    } else if (textType == TextType.plainText) {
      return FaIcon(Icons.copy_all_rounded, color: black);
    }

    return FaIcon(FontAwesomeIcons.internetExplorer, color: purple);
  }

  void _openIntent(BuildContext context) async {
    Uri? uri;

    CustomLoading.showLoading(context);

    if (textType == TextType.email) {
      uri = Uri(scheme: 'mailto', path: text);
    } else if (textType == TextType.number) {
      uri = Uri(scheme: 'tel', path: text);
    } else if (textType == TextType.url) {
      uri = Uri(path: text);
    }

    if (uri != null) {
      if (textType == TextType.url) {
        await launchUrlString(text, mode: LaunchMode.inAppWebView);
      } else {
        await launchUrlString(uri.toString());
      }
    } else {
      await Clipboard.setData(ClipboardData(text: text));
    }

    CustomLoading.dismiss();
  }
}
