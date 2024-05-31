import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/CreatNewBookPage.dart';
import '../ui/CreatTxtBookPage.dart';

var noPaddingBS = ButtonStyle(
  padding: MaterialStateProperty.all(EdgeInsets.all(0)),
  shadowColor: MaterialStateProperty.all(Colors.transparent),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
  foregroundColor: MaterialStateProperty.all(Colors.transparent),
);

Future<void> alertEdit(String hint, String msg, Function(String) call,
    BuildContext context) async {
  SmartDialog.show(
      animationTime: Duration.zero,
      builder: (c) {
        return CreatNewBookPage(hint, msg, call);
      });
}

Future<void> alertEditTxt(
    String hint, Function(String) call, BuildContext context) async {
  SmartDialog.show(
      animationTime: Duration.zero,
      builder: (c) {
        return CreatNewBookTxtPage(hint, call);
      });
}
