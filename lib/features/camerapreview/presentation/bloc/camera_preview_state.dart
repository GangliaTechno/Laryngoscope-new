part of 'camera_preview_bloc.dart';

@immutable
sealed class CameraPreviewState {}

final class CameraPreviewInitial extends CameraPreviewState {}

class CameraPreviewLoading extends CameraPreviewState{}

class CameraPreviewSuccess extends CameraPreviewState{
   final CameraController controller;
  CameraPreviewSuccess(this.controller);
}

class CameraPreviewError extends CameraPreviewState{
  final String errMessage;
  CameraPreviewError(this.errMessage);
}

