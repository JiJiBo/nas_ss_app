import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mf.dart';
import '../mobx/route.dart';
import '../utils/PerUtils.dart';

class HomePage extends StatefulObserverWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initTheFirst();
  }

  GlobalKey anchorKey = GlobalKey();

  @override
  void dispose() {
    eventListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("首页"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: ListView(
            children: [
              ListTile(
                title: Text("小说"),
                leading: Image.asset(
                  "小说.png".toAssets,
                  width: 40,
                  height: 40,
                ),
                onTap: () {
                  routeStore.small_say_route.push(context);
                },
              ),
              ListTile(
                title: Text("设置"),
                leading: Icon(
                  Icons.settings,
                  size: 40,
                ),
                onTap: () {
                  routeStore.setting_route.push(context);
                },
              ),
              ListTile(
                title: Text("用户"),
                leading: Icon(
                  Icons.person,
                  size: 40,
                ),
                onTap: () {
                  routeStore.user_route.push(context);
                },
              ),
              // ListTile(
              //   title: Text("angry"),
              //   leading: Image.asset(
              //     "表情.png".toAssets,
              //     width: 40,
              //     height: 40,
              //   ),
              //   onTap: () {
              //     routeStore.angry_route.push(context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool isDown = false;
  StreamSubscription<DownLine>? eventListener;

  void initTheFirst() {
    eventListener = eventBus.on<DownLine>().listen((event) {
      if (isDown) {
        return;
      }
      //双击检测
      isDown = true;
      try {
        "".save("token");
        Navigator.of(context).pushNamedAndRemoveUntil(
            routeStore.welcome_ui_route, (route) => false);
      } catch (e) {}
    });
  }
}

class DownLine {}
