import 'package:flutter/material.dart';
import 'package:text_recognition_app/src/utils/api_endpoint_page.dart';
import 'package:text_recognition_app/src/utils/strings.dart';

void main() {
  runApp(const TextRecognitionApp());
}

class TextRecognitionApp extends StatelessWidget {
  const TextRecognitionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: mainFontFamily),
      home: APIEndpointPage(),
    );
  }
}
