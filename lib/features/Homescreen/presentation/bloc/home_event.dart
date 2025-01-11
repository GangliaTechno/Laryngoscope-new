part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class Homeinitial extends HomeEvent {}

//event for appbar collapse on clickcing the body
class BodyClicked extends HomeEvent {}

//event for rotating screen to landscape or potrait
class OnScreenOrientation extends HomeEvent {}

//event for toggling frontcaera tobackcamera in camerapreview
class CameraToggleEvent extends HomeEvent {}

//event for Batteryevel alert
class CheckBatteryLevel  extends HomeEvent{}


class VideoCallIconClicked extends HomeEvent{}


class CameraIconClickedEvent extends HomeEvent {}