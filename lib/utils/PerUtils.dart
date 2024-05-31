import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'alert.dart';

Future<void> getCameraPer(
    BuildContext context, String alertFieldName, Function callback) async {
  if (kIsWeb) {
    callback(true);
  } else if (Platform.isAndroid || Platform.isIOS) {
    await getAnyPer(Permission.camera, context, alertFieldName, callback);
  } else {
    callback(true);
  }
}

Future<void> getMicrophonePer(
    BuildContext context, String alertFieldName, Function callback) async {
  if (kIsWeb) {
    callback(true);
  } else if (Platform.isAndroid || Platform.isIOS) {
    await getAnyPer(Permission.microphone, context, alertFieldName, callback);
  } else {
    callback(true);
  }
}

Future<void> getAnyPer(Permission per, BuildContext context,
    String alertFieldName, Function callback) async {
  if (Platform.isAndroid || Platform.isIOS) {
    var status = await per.status;
    if (!status.isGranted) {
      alert(context, alertFieldName, (isOk) async {
        if (isOk) {
          await per.request();
        }
        callback(isOk);
      });
    } else {
      callback(true);
    }
  } else {
    callback(true);
  }
}
