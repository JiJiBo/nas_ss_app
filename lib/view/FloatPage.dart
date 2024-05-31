import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mobx/play_manager.dart';
import '../mobx/route.dart';

class FloatPage extends StatefulObserverWidget {
  @override
  _FloatPageState createState() => _FloatPageState();
}

class _FloatPageState extends State<FloatPage> {
  @override
  void initState() {
    super.initState();
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          routeStore.play_route.push(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDuration(
                    Duration(seconds: playManager.currentSliderValue.toInt())),
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Text(
                "/",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Text(
                formatDuration(Duration(
                    seconds: playManager.player.duration?.inSeconds.toInt() ??
                        playManager.maxSliderValue.toInt())),
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
