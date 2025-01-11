import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


part 'camera_preview_event.dart';
part 'camera_preview_state.dart';

class CameraPreviewBloc extends Bloc<CameraPreviewEvent, CameraPreviewState> {
  CameraController? _controller;
   int _currentCameraIndex = 0;
   List<CameraDescription>? _cameras;
  CameraPreviewBloc() : super(CameraPreviewInitial()) {
    on<InitializeCameraPreview>(_onInitializeCamera);
    on<DisposeCameraPreview>(_onDisposeCamera);
    on<SwitchCamera>(_onSwitchCamera);
  }
    Future<void> _onInitializeCamera(
      InitializeCameraPreview event, Emitter<CameraPreviewState> emit) async {
    emit(CameraPreviewLoading());
    try {
      // Retrieve available cameras
      _cameras = await availableCameras();
      if (_cameras!.isEmpty) throw Exception('No cameras available');

      // Initialize the first camera by default
      _currentCameraIndex = 0;
      await _initializeController(emit);
    } catch (e) {
      emit(CameraPreviewError("Error initializing camera: $e"));
    }
  }

  Future<void> _initializeController(Emitter<CameraPreviewState> emit) async {
    try {
      _controller?.dispose(); // Dispose of the old controller if any

      _controller = CameraController(
        _cameras![_currentCameraIndex],
        ResolutionPreset.high,
      );

      await _controller!.initialize();
      emit(CameraPreviewSuccess(_controller!));
    } catch (e) {
      emit(CameraPreviewError("Error switching camera: $e"));
    }
  }

  Future<void> _onSwitchCamera(
      SwitchCamera event, Emitter<CameraPreviewState> emit) async {
    try {
      // Toggle the camera index between front and back
      _currentCameraIndex =
          (_currentCameraIndex + 1) % _cameras!.length; // Switch cameras
      await _initializeController(emit);
    } catch (e) {
      emit(CameraPreviewError("Error switching camera: $e"));
    }
  }

  Future<void> _onDisposeCamera(
      DisposeCameraPreview event, Emitter<CameraPreviewState> emit) async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      emit(CameraPreviewInitial());
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
