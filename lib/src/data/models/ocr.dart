import 'dart:convert';

import 'package:text_recognition_app/src/utils/enums.dart';

class Ocr {
  final Map<String, TextType> categorizedTexts;
  final String fileKey;

  Ocr({
    required this.categorizedTexts,
    required this.fileKey,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'categorized_texts': categorizedTexts});
    result.addAll({'file_key': fileKey});

    return result;
  }

  factory Ocr.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> rawCt = map['categorized_texts'];

    final Map<String, TextType> ct = {};

    rawCt.forEach((k, v) {
      ct[k] = ParseTextType.parse(v);
    });

    return Ocr(
      categorizedTexts: ct,
      fileKey: map['file_key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ocr.fromJson(String source) => Ocr.fromMap(json.decode(source));
}
