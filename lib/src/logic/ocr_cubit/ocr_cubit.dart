import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_recognition_app/src/data/repository/ocr_repository.dart';
import 'package:text_recognition_app/src/utils/exception.dart';

import '../../data/models/ocr.dart';

part 'ocr_state.dart';

class OcrCubit extends Cubit<OcrState> {
  OcrCubit() : super(OcrInitial());

  final OcrRepository _ocrRepository = OcrRepository();

  Future<void> postImage(String imagePath) async {
    final result = await _ocrRepository.postImage(imagePath);

    result.fold((e) => emit(OcrError(serverException: e)),
        (ocr) => emit(OcrProcessed(ocr: ocr)));
  }

  Future<void> getImage(String imageKey) async {
    final result = await _ocrRepository.getImage(imageKey);

    result.fold((e) => emit(OcrError(serverException: e)),
        (image) => emit(OcrImage(image: image)));
  }
}
