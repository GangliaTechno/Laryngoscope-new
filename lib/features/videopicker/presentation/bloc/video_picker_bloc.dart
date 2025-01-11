import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'video_picker_event.dart';
part 'video_picker_state.dart';

class VideoPickerBloc extends Bloc<VideoPickerEvent, VideoPickerState> {
  final ImagePicker _videopicker = ImagePicker();
  VideoPickerBloc() : super(VideoPickerInitial()) {
   on<PickVideoEvent>((event, emit) async {
      try {
        final pickedFile = await _videopicker.pickVideo(source: ImageSource.gallery);
        if (pickedFile != null) {
          emit(VideoPickedSuccess(pickedFile.path));
        } else {
          emit(VideoPicKFailure("No video selected"));
        }
      } catch (e) {
        emit(VideoPicKFailure("Error picking video: $e"));
      }
    });

     on<DeleteVideoEvent>((event, emit) {
      emit(VideoPickerInitial());
    });
  }
}
