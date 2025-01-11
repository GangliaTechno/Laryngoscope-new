import 'package:flutter/material.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/pages/home_screen.dart';
import 'package:laryngoscope/features/videocall/presentation/pages/call.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/elevated_button.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/text_feild.dart';

class VideocallScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  static route(_) => MaterialPageRoute(builder: (context) => VideocallScreen());

  VideocallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, HomeScreen.route(context));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppPallette.iconBg,
            size: 20,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/call.png'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'CONNECT TO THE WORLD.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppPallette.iconBg,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                  textFeild(
                  hintText: 'Enter Your Name',
                  controller: _namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name!!';
                    }
                    return null; // Valid input
                  },
                ),
                  SizedBox(
                  height: 20,
                ),
                textFeild(
                  hintText: 'Enter Call ID',
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a call ID!!';
                    }
                    if (value.length < 3) {
                      return 'Call ID must be at least 3 characters long';
                    }
                    return null; // Valid input
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GradientButton(
                  buttonTxt: 'Join Call',
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed if validation passes
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallPage(
                            callID: _controller.text.toString(),
                            userName: _namecontroller.text.toString(),
                          ),
                        ),
                      );
                      _controller.clear();
                      _namecontroller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
