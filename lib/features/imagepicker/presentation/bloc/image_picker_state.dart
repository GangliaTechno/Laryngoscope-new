part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}


class ImagePickedSuccess extends ImagePickerState {
  final String imagePath;

  ImagePickedSuccess(this.imagePath);
}



class ImageDeleteSuccess extends ImagePickerState {}



class ImageFailure extends ImagePickerState {
  final String error;

  ImageFailure(this.error);
}


