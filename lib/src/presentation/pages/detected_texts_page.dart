import 'dart:io';

import 'package:flutter/material.dart';
import 'package:text_recognition_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:text_recognition_app/src/presentation/widgets/text_intent_widget.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/enums.dart';
import 'package:text_recognition_app/src/utils/strings.dart';
import 'package:velocity_x/velocity_x.dart';

class DetectedTextsPage extends StatelessWidget {
  const DetectedTextsPage({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, detectedTextsPageTitle, isSubPage: true),
      body: VStack([
        // output image
        Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        )
            .box
            .height(CustomMediaQuery.makeHeight(context, .3))
            .width(context.screenWidth)
            .make(),

        // list of detected texts
        ListView(
          shrinkWrap: true,
          children: const [
            TextIntentWidget(
                text: 'Angad38.agcs@gmail.com', textType: TextType.plainText)
          ],
        )
      ]),

      //
    );
  }
}
