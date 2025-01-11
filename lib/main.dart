import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/pages/home_screen.dart';
import 'package:laryngoscope/features/camerapreview/presentation/bloc/camera_preview_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/bloc/image_picker_bloc.dart';
import 'package:laryngoscope/features/videopicker/presentation/bloc/video_picker_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()..add(CheckBatteryLevel())),
        BlocProvider(create: (_) => ImagePickerBloc()),
        BlocProvider(create: (_) => VideoPickerBloc()),
        BlocProvider(create: (_) => CameraPreviewBloc()..add(InitializeCameraPreview())),
      ],
      child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
  }
}
