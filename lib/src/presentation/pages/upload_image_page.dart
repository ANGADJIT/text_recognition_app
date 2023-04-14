import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_recognition_app/src/data/dataprovider/ocr_api.dart';
import 'package:text_recognition_app/src/logic/ocr_cubit/ocr_cubit.dart';
import 'package:text_recognition_app/src/presentation/pages/detected_texts_page.dart';
import 'package:text_recognition_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:text_recognition_app/src/utils/colors.dart';
import 'package:text_recognition_app/src/utils/custom_loading.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/enums.dart';
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

  final OcrCubit _ocrCubit = OcrCubit();

  @override
  void dispose() {
    _ocrCubit.close();

    super.dispose();
  }

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
          onPressed: _postImage,
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
  void _navigate(Map<String, TextType> categorizedTexts, Uint8List image) {
    if (_imagePath != null) {
      context.nextPage(DetectedTextsPage(
        categorizedTexts: categorizedTexts,
        image: image,
      ));
    }
  }

  Future<void> _pickImage() async =>
      _imagePath = await _mediaManager.getImage();

  void _postImage() async {
    CustomLoading.showLoading(context);

    await _pickImage();

    if (_imagePath != null) {
      _ocrCubit.postImage(_imagePath!).then((_) {
        if (_ocrCubit.state is OcrProcessed) {
          final Map<String, TextType> categorizedTexts =
              (_ocrCubit.state as OcrProcessed).ocr.categorizedTexts;

          final String imageKey = (_ocrCubit.state as OcrProcessed).ocr.fileKey;

          _ocrCubit.getImage(imageKey).then((image) {
            if (_ocrCubit.state is OcrImage) {
              final Uint8List pngImage = (_ocrCubit.state as OcrImage).image;

              // navigate to next screen
              _navigate(categorizedTexts, pngImage);
            } else if (_ocrCubit.state is OcrError) {
              final error =
                  (_ocrCubit.state as OcrError).serverException.errorMessage;
              VxToast.show(context, msg: error);
            }
          });
        } else if (_ocrCubit.state is OcrError) {
          final error =
              (_ocrCubit.state as OcrError).serverException.errorMessage;

          print(error);
          VxToast.show(context,
              msg: (_ocrCubit.state as OcrError).serverException.toString());
        }

        CustomLoading.dismiss();
      });
    }
  }
}
