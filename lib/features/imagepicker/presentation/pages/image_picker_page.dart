import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/pages/home_screen.dart';
import 'package:laryngoscope/features/imagepicker/presentation/bloc/image_picker_bloc.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/elevated_button.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ImagePickerPage extends StatelessWidget {
  final String imagePath;

  const ImagePickerPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, HomeScreen.route(context));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppPallette.iconBg,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrapping Zoom widget with a container to ensure a defined size
            Expanded(
              child: Zoom(
                backgroundColor: Colors.transparent,
                maxZoomWidth: 500,
                maxZoomHeight: 500,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(20.0),
                child: GradientButton(
                    buttonTxt: 'Delete Image',
                    onpressed: () {
                      context.read<ImagePickerBloc>().add(DeleteImageEvent());
                      Navigator.pop(context);
                    })),
          ],
        ),
      ),
    );
  }
}
