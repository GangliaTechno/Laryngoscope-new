import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/elevated_button.dart';
import 'package:laryngoscope/features/videopicker/presentation/bloc/video_picker_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPickerPage extends StatelessWidget {
  final String videoPath;
  const VideoPickerPage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    VideoPlayerController _controller = VideoPlayerController.file(File(videoPath));

    // Initialize the video controller
    Future<void> _initializeController() async {
      await _controller.initialize();
      _controller.play();
    }

    return BlocListener<VideoPickerBloc, VideoPickerState>(
      listener: (context, state) {
        if (state is VideoPickerInitial) {
          // Stop the video playback when the video is deleted
          _controller.pause();
          _controller.dispose();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.read<VideoPickerBloc>().add(DeleteVideoEvent());
                    Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppPallette.iconBg,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _initializeController(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GradientButton(
                  buttonTxt: 'Delete Video',
                  onpressed: () {
                    // Trigger the delete video event
                    context.read<VideoPickerBloc>().add(DeleteVideoEvent());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
