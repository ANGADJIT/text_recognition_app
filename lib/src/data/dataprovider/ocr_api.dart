import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:text_recognition_app/src/utils/base_api.dart';
import 'package:text_recognition_app/src/utils/exception.dart';

class OcrAPI extends BaseApi {
  Future<String> postImage(String imagePath) async {
    String body = '';

    final Map<String, dynamic> headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };

    try {
      final Response response = await post(
          route: 'process_image',
          headers: headers,
          isForm: true,
          data: {},
          file: File(imagePath));

      body = jsonEncode(response.data);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }

    return body;
  }
}
