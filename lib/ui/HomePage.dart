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

  void initTheFirst() {}
}
