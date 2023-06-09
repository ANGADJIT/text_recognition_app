import 'package:flutter/material.dart';
import 'package:text_recognition_app/src/presentation/pages/upload_image_page.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/strings.dart';
import 'package:velocity_x/velocity_x.dart';
import 'cache_manager.dart';
import 'colors.dart';

class APIEndpointPage extends StatelessWidget {
  APIEndpointPage({super.key});

  final TextEditingController _host = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: VStack([
        CustomMediaQuery.makeHeight(context, .15).heightBox,

        //
        VxTextField(
          cursorColor: black,
          fillColor: white,
          hint: apiEndpointTextFieldHint,
          borderType: VxTextFieldBorderType.roundLine,
          borderRadius: CustomMediaQuery.makeRadius(context, .1),
          controller: _host,
          borderColor: blue,
        ),

        //
        CustomMediaQuery.makeHeight(context, .09).heightBox,
        OutlinedButton(
                onPressed: () => {
                      CacheManager.cacheApiHost(_host.text),
                      context.nextReplacementPage(const UploadImagePage())
                    },
                child: addUrlButtonText.text.make())
            .centered(),
        OutlinedButton(
                onPressed: () =>
                    context.nextReplacementPage(const UploadImagePage()),
                child: usePreviousButtonText.text.make())
            .centered(),
      ]).px(CustomMediaQuery.makeWidth(context, .04)))),
    );
  }
}
