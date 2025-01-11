part of 'video_picker_bloc.dart';

@immutable
sealed class VideoPickerState {}

final class VideoPickerInitial extends VideoPickerState {}


class VideoPickedSuccess extends VideoPickerState{
  final String videoPath;
  VideoPickedSuccess(this.videoPath);
}


class VideoPicKFailure extends VideoPickerState{
  final String error;
  VideoPicKFailure(this.error);
}