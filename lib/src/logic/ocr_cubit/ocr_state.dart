part of 'ocr_cubit.dart';

abstract class OcrState extends Equatable {
  const OcrState();

  @override
  List<Object> get props => [];
}

class OcrInitial extends OcrState {}

class OcrError extends OcrState {
  final ServerException serverException;

  const OcrError({
    required this.serverException,
  });

  @override
  List<Object> get props => [serverException];
}

class OcrProcessed extends OcrState {
  final Ocr ocr;

  const OcrProcessed({
    required this.ocr,
  });

  @override
  List<Object> get props => [ocr];
}

class OcrImage extends OcrState {
  final Uint8List image;

  const OcrImage({
    required this.image,
  });

  @override
  List<Object> get props => [image];
}
