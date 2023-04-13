import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:text_recognition_app/src/data/dataprovider/ocr_api.dart';
import 'package:text_recognition_app/src/data/models/ocr.dart';
import 'package:text_recognition_app/src/utils/exception.dart';

class OcrRepository {
  final OcrAPI _ocrAPI = OcrAPI();

  Future<Either<ServerException, Ocr>> postImage(String imagePath) async {
    Ocr ocr;

    try {
      final String body = await _ocrAPI.postImage(imagePath);
      ocr = Ocr.fromJson(body);
    } catch (e) {
      return left(ServerException(errorMessage: e.toString()));
    }

    return right(ocr);
  }

  Future<Either<ServerException, Uint8List>> getImage(String imageKey) async {
    Uint8List image;

    try {
      image = await _ocrAPI.getImage(imageKey);
    } catch (e) {
      return left(ServerException(errorMessage: e.toString()));
    }

    return right(image);
  }
}
