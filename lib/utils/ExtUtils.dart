import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nas_ss_app/ui/HomePage.dart';

import '../mobx/route.dart';
import 'DioUtils.dart';

extension RouteExt on String {
  void push(BuildContext context, {Object? args = null}) {
    Navigator.pushNamed(context, this, arguments: args);
  }
}

extension StrExt on String {
  File get toFile => File(this);

  String get toAssets => "assets/" + this;

  String get toUrlFile {
    return url + "/files/" + this;
  }

  String get toMp3File {
    return "http://${routeStore.fileUrl}${routeStore.filePort.isEmpty ? "" : ":" + routeStore.filePort}/download?filename=" +
        this;
  }

  Uint8List get toUint8List => this.toFile.readAsBytesSync();
}

extension DurationExt on Duration {
  Future<void> delayed() async {
    await Future.delayed(this);
  }
}

extension BuildContextExt on BuildContext {
  Object? get getTheArg {
    return ModalRoute.of(this)!.settings.arguments;
  }
}

extension ResponseExt on Response<Map> {
  bool isSuccess() {
    print(this.data);
    if (this.data!["code"] == 401) {
      eventBus.fire(DownLine());
      return false;
    }
    return this.data!["code"] == 200;
  }

  Map getData() {
    print(this.data);
    return this.data!["data"];
  }
}
