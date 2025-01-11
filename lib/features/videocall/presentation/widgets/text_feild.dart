import 'package:flutter/material.dart';
import 'package:laryngoscope/core/app_pallette.dart';

class textFeild extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const textFeild(
      {super.key, required this.hintText, required this.controller,this.validator});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 290,
        child: TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: Icon( 
                    Icons.cancel,
                    color: AppPallette.iconBg,
                  )),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 19),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
               errorBorder: OutlineInputBorder( 
                borderRadius: BorderRadius.circular(10),// Red border when validation fails
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder( 
                borderRadius: BorderRadius.circular(10),// Red border when validation fails
                borderSide: BorderSide(color: Colors.red, width: 2),
              ) ,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppPallette.borderClr, width: 2),
              )),
        ),
      ),
    );
  }
}
