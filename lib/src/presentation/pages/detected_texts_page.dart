import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_recognition_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:text_recognition_app/src/presentation/widgets/text_intent_widget.dart';
import 'package:text_recognition_app/src/utils/custom_media_query.dart';
import 'package:text_recognition_app/src/utils/enums.dart';
import 'package:text_recognition_app/src/utils/strings.dart';
import 'package:velocity_x/velocity_x.dart';

class DetectedTextsPage extends StatefulWidget {
  const DetectedTextsPage(
      {Key? key, required this.image, required this.categorizedTexts})
      : super(key: key);
  final Uint8List image;
  final Map<String, TextType> categorizedTexts;

  @override
  State<DetectedTextsPage> createState() => _DetectedTextsPageState();
}

class _DetectedTextsPageState extends State<DetectedTextsPage> {
  final List<TextIntentWidget> _textIntents = [];

  @override
  void initState() {
    super.initState();

    _generateTextIntents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, detectedTextsPageTitle, isSubPage: true),
      body: ListView(children: [
        // output image
        Image.memory(
          widget.image,
          fit: BoxFit.cover,
        ).box.height(CustomMediaQuery.makeHeight(context, .3)).make(),

        // list of detected texts
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _textIntents.length,
          itemBuilder: ((context, index) => _textIntents[index]),
        )
      ]),

      //
    );
  }

  // generate list of TextIntent
  void _generateTextIntents() => {
        widget.categorizedTexts.forEach((key, value) {
          _textIntents.add(TextIntentWidget(text: key, textType: value));
        }),
        setState(() {})
      };
}
