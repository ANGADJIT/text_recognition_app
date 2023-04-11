import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_recognition_app/src/data/dataprovider/ocr_api.dart';
import 'package:text_recognition_app/src/presentation/pages/detected_texts_page.dart';
import 'package:text_recognition_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:text_recognition_app/src/utils/colors.dart';
import 'package:text_recognition_app/src/utils/custom_loading.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/media_manager.dart';
import 'package:text_recognition_app/src/utils/strings.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  // image path
  String? _imagePath;

  final MediaManager _mediaManager = MediaManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(context, titleText),
      body: SafeArea(
          child: VStack([
        //
        CustomMediaQuery.makeHeight(context, .1).heightBox,
        Image.asset('assets/images/upload_file.jpg').centered(),

        //
        CustomMediaQuery.makeHeight(context, .05).heightBox,
        uploadFileUserText.text.center
            .color(gray)
            .italic
            .semiBold
            .size(CustomMediaQuery.makeTextSize(context, .5))
            .makeCentered(),

        //
        CustomMediaQuery.makeHeight(context, .07).heightBox,
        MaterialButton(
          onPressed: () async {
            CustomLoading.showLoading(context);
            _imagePath = await _mediaManager.getImage();

            final api = OcrAPI();

            if (_imagePath != null) {
              try {
                api.postImage(_imagePath!);
              } catch (e) {
                VxToast.show(context, msg: e.toString());
              }
            }
            CustomLoading.dismiss();
            _navigate();
          },
          child: VxBox(
                  child: FaIcon(
            FontAwesomeIcons.upload,
            color: white,
          ).centered())
              .color(purple)
              .roundedFull
              .shadow2xl
              .square(CustomMediaQuery.makeSize(context, .8))
              .make(),
        ).centered()
      ])),
    );
  }

  // navigate to another page
  void _navigate() {
    if (_imagePath != null) {
      context.nextPage(DetectedTextsPage(
        imagePath: _imagePath!,
      ));
    }
  }
}
