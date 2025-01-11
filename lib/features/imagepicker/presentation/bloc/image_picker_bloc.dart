import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImageEvent>((event, emit) async {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(ImagePickedSuccess(pickedFile.path));
        } else {
          emit(ImageFailure("No image selected"));
        }
      } catch (e) {
        emit(ImageFailure("Error picking image: $e"));
      }
    });

    on<DeleteImageEvent>((event, emit) async{
      emit(ImagePickerInitial());
    });

  
  }
}
