import 'package:flutter/material.dart';
import 'package:laryngoscope/core/app_pallette.dart';

class GradientButton extends StatelessWidget {
  final String buttonTxt;
  final VoidCallback onpressed;
  const GradientButton(
      {super.key, required this.buttonTxt, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: [
            AppPallette.gradient1,
            Colors.green,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Text(buttonTxt)),
    );
  }
}
