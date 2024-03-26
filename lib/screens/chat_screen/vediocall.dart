import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

String userId = Random().nextInt(10000).toString();

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 1138912062,
        appSign:
        '88a24f13c35299aed1bc42f99a156f5d8617f69c071c49598878a6be8f312fe2',
        callID: callID,
        userID: userId,
        userName: 'user_$userId',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
