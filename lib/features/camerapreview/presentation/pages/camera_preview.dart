import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/features/camerapreview/presentation/bloc/camera_preview_bloc.dart';

class CameraPreviewPage extends StatelessWidget {
  const CameraPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraPreviewBloc, CameraPreviewState>(
      builder: (context, state) {
        if (state is CameraPreviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CameraPreviewSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: state.controller.value.aspectRatio,
              child: CameraPreview(state.controller),
            ),
          );
        } else if (state is CameraPreviewError) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
        return const Center(child: Text('Initializing camera...'));
      },
    );
  }
}
