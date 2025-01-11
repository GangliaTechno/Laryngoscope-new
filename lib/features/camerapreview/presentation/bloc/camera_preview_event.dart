part of 'camera_preview_bloc.dart';

@immutable
sealed class CameraPreviewEvent {}

class InitializeCameraPreview extends CameraPreviewEvent{}  //Initializing CameraPerview.

class DisposeCameraPreview extends CameraPreviewEvent{}  //Disposing CameraPreview.

class SwitchCamera extends CameraPreviewEvent{} //Switching Camera In CameraPreview.