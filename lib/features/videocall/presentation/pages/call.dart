import 'package:flutter/material.dart';
import 'package:laryngoscope/core/secrets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID,required this.userName}) : super(key: key);
  final String callID;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Secrets
          .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: Secrets
          .appSignin, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userName,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
