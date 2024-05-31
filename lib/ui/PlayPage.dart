import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mobx/play_manager.dart';
import '../utils/DioUtils.dart';
import '../view/AudioView.dart';

class PlayPage extends StatefulObserverWidget {
  @override
  _PlayPage createState() {
    return _PlayPage();
  }
}

class _PlayPage extends State<PlayPage> {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(playManager.name),
        ),
        body: AudioView());
  }

  Future<void> initForFirst() async {
    await Duration.zero.delayed();
    setState(() {});
  }
}
