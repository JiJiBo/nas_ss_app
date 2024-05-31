import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mf.dart';
import '../mobx/play_manager.dart';
import '../mobx/route.dart';

class WelcomePage extends StatefulObserverWidget {
  @override
  _WelcomePage createState() {
    return _WelcomePage();
  }
}

class _WelcomePage extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    initTheFirst();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 40.0,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Nas Ss App'),
                FlickerAnimatedText(
                  'By Nas Neo',
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                Navigator.pop(context);
                if ("token".getString(defaultValue: "").isNotEmpty) {
                  routeStore.home_ui_route.push(context);
                } else {
                  routeStore.login_route.push(context);
                }
              },
            ),
          ),
        ));
  }

  Future<void> initTheFirst() async {
    Future.delayed(Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pop(context);
        if ("token".getString(defaultValue: "").isNotEmpty) {
          routeStore.home_ui_route.push(context);
        } else {
          routeStore.login_route.push(context);
        }
      }
    });
  }
}
