import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/widgets/icon_widgets.dart';
import 'package:laryngoscope/features/camerapreview/presentation/pages/camera_preview.dart';
import 'package:laryngoscope/features/videocall/presentation/pages/videocall_screen.dart';

class HomeScreen extends StatelessWidget {
  static route(_) => MaterialPageRoute(builder: (context) => HomeScreen());
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ScreenOrientationChanged) {
          SystemChrome.setPreferredOrientations(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? [DeviceOrientation.landscapeLeft]
                : [DeviceOrientation.portraitUp],
          );
        }
         if (state is BatteryLow) {
               print('BatteryLow state detected: ${state.batteryLevel}');
              showLowBatteryDialog(context, state.batteryLevel);
            }

            
            if(state is LoadVideoCallPage){
              Navigator.push(context, VideocallScreen.route(context));
            }
             if (state is OpenCameraSuccess) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Image saved at ${state.imagePath}')),
                    // );
                  } else if (state is OpenCameraFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
        
      },
      builder: (context, state) {
        bool showAppBar = true;
        if (state is AppBarToggleSuccess) {
          showAppBar = state.showAppBar;
        }
       

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: FadeInDown(
                    delay: Duration(milliseconds: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCameraIcon(context),
                        selectImageIcon(context),
                        selectVideoIcon(context),
                        videoCallIcon(context),
                        screenRotationIcon(context),
                      ],
                    ),
                  ),
                )
              : null,
          body: GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(CheckBatteryLevel());
              context.read<HomeBloc>().add(BodyClicked());
            },
            child: CameraPreviewPage(),
          ),
          floatingActionButton: showAppBar? flipCameraButton(context): null,
        );
      },
    );
  }
}

