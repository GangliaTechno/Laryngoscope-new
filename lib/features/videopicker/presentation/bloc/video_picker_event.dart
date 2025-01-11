part of 'video_picker_bloc.dart';

@immutable
sealed class VideoPickerEvent {}

//Event for pickcing the video from gallery
class PickVideoEvent extends VideoPickerEvent{}


//Event to delete the picked video 
class DeleteVideoEvent extends VideoPickerEvent{}