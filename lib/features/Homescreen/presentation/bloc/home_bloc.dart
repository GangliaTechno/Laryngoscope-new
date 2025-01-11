import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool _showAppBar = true;
  late CameraController cameraController;
   final ImagePicker _imagePicker = ImagePicker();
  int selectedCameraIndex = 0;
  late Battery _battery; 
  Timer? _timer;
  List<CameraDescription> cameras = [];
  HomeBloc() : super(HomeInitial()) {
//bodyclicked
    on<BodyClicked>((event, emit) {
      _showAppBar = !_showAppBar;
      emit(AppBarToggleSuccess(showAppBar: _showAppBar));
    });
//screenrotation
    on<OnScreenOrientation>((event, emit) {
      emit(ScreenOrientationChanged());
    });

   on<CheckBatteryLevel>((event, emit) async {
  try {
    final batteryLevel = await _battery.batteryLevel;
    print("Battery Level: $batteryLevel");
    if (batteryLevel < 80) {
      print("Emitting BatteryLow state with level $batteryLevel");
      emit(BatteryLow(batteryLevel));
    } else {
      emit(BatteryNormal());
    }
  } catch (e) {
    emit(BatteryNormal());
  }
});

      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
            add(CheckBatteryLevel());
        });



      on<VideoCallIconClicked>((event, emit) {
        emit(LoadVideoCallPage());
      });


       on<CameraIconClickedEvent>((event, emit) async {
       try {
        // Open the system camera
        await _imagePicker.pickImage(source: ImageSource.camera);
      } catch (e) {
        emit(OpenCameraFailure('Failed to launch camera: $e'));
      }
    }
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
  
}
