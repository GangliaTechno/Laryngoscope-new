part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class AppBarToggleSuccess extends HomeState {
  final bool showAppBar;
  AppBarToggleSuccess({required this.showAppBar});
}


class ScreenOrientationChanged extends HomeState {}


class CameraToggleSuccess extends HomeState {
  final CameraController cameraController;
  CameraToggleSuccess(this.cameraController);
}


class CameraToggleFailure extends HomeState {
  final String error;
  CameraToggleFailure(this.error);
}


class BatteryLow extends HomeState {
  final int batteryLevel;

  BatteryLow(this.batteryLevel);
}


class BatteryNormal extends HomeState {}




class OpenCameraSuccess extends HomeState{
  final String imagePath;
  OpenCameraSuccess(this.imagePath);
}


class OpenCameraFailure extends HomeState{
  final String error;
  OpenCameraFailure(this.error);
}
