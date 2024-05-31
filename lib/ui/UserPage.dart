import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/mobx/route.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

class UserPage extends StatefulObserverWidget {
  @override
  _UserPage createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  String name = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: ListTile(
          title: Text("退出"),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('注意'),
                  content: Text('退出'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text('取消'),
                    ),
                    TextButton(
                      onPressed: out,
                      child: Text('退出'),
                    ),
                  ],
                );
              },
            );
          },
        ));
  }

  void out() {
    ("").save("id");
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    routeStore.login_route.push(context);
  }

  void initForFirst() {
    name = "userName".getString(defaultValue: "");
    setState(() {});
  }
}
