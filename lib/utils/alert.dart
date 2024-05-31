
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(BuildContext context, String alertFieldName, Function callback) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("提示"),
        content: Text('$alertFieldName'),
        actions: <Widget>[
          TextButton(
            child: Text("确认"),
            onPressed: () {
              callback(true);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("取消"),
            onPressed: () {
              callback(false);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
