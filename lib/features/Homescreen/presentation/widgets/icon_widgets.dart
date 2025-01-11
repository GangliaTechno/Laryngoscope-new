import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/camerapreview/presentation/bloc/camera_preview_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/bloc/image_picker_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/pages/image_picker_page.dart';
import 'package:laryngoscope/features/videopicker/presentation/bloc/video_picker_bloc.dart';
import 'package:laryngoscope/features/videopicker/presentation/pages/video_picker_page.dart';
import '../../../../core/app_pallette.dart';



Widget buildCameraIcon(BuildContext context) {
  return  IconButton(
      onPressed: () {
         context.read<HomeBloc>().add(CameraIconClickedEvent());
        //  context.read<CameraBloc>().add(CaptureImageEvent());
      },
      icon: Icon(Icons.camera_alt, color: AppPallette.iconBg, size: 25),
    );
}



Widget selectImageIcon(BuildContext context) {
  return BlocListener<ImagePickerBloc, ImagePickerState>(
    listener: (context, state) {
      if (state is ImagePickedSuccess) {
        // Navigate to ImagePickerPage when image is picked successfully
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImagePickerPage(imagePath: state.imagePath),
          ),
        );
      }
    },
    child: IconButton(
      onPressed: () {
        context.read<ImagePickerBloc>().add(PickImageEvent());
       
      },
      icon: Icon(Icons.photo_size_select_actual_rounded,
          color: AppPallette.iconBg, size: 25),
    ),
  );
}

Widget selectVideoIcon(BuildContext context) {
  return BlocListener<VideoPickerBloc, VideoPickerState>(
    listener: (context, state) {
      if (state is VideoPickedSuccess) {
        // Navigate to ImagePickerPage when image is picked successfully
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPickerPage(videoPath: state.videoPath),
          ),
        );
      }
    },
    child: IconButton(
        onPressed: () {
          context.read<VideoPickerBloc>().add(PickVideoEvent());
        },
        icon: Icon(Icons.video_camera_back_sharp,
            color: AppPallette.iconBg, size: 25)),
  );
}

Widget videoCallIcon(BuildContext context) {
  return IconButton(
      onPressed: () {
       context.read<HomeBloc>().add(VideoCallIconClicked());
      },
      icon: Icon(Icons.video_call, color: AppPallette.iconBg, size: 25));
}

Widget screenRotationIcon(BuildContext context) {
  return IconButton(
      onPressed: () {
        context.read<HomeBloc>().add(OnScreenOrientation());
      },
      icon: Icon(Icons.screen_rotation_alt_outlined,
          color: AppPallette.iconBg, size: 25));
}

Widget flipCameraButton(BuildContext context) {
  return FadeInUp(
                delay: Duration(milliseconds: 100),
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: AppPallette.buttonBg,
                    onPressed: () {
                      context.read<CameraPreviewBloc>().add(SwitchCamera());
                    },
                    child: Icon(
                      Icons.flip_camera_ios,
                      color: AppPallette.iconBg,
                    ),
                  ),
              );
}

  void showLowBatteryDialog(BuildContext context, int batteryLevel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Low Battery'),
        content: Text('Battery level is low: $batteryLevel%'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}