import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class OutCameraView extends StatefulObserverWidget {
  @override
  _OutCameraView createState() {
    return _OutCameraView();
  }
}

class _OutCameraView extends State<OutCameraView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body: Center(
          child: Text("empty ui"),
        ));
  }
}
