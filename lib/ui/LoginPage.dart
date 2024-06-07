import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mobx/play_manager.dart';
import '../mobx/route.dart';
import '../utils/DioUtils.dart';

class LoginPage extends StatefulObserverWidget {
  @override
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // 在这里编写注册逻辑，可以将用户名和密码发送到后端进行处理
    String username = _usernameController.text;
    String password = _passwordController.text;
    var post = await login(username, password);
    if (post.isSuccess()) {
      post.getData()["token"].toString().save("token");
      "token".getString(defaultValue: "").bbLogD(tag: "token");
      username.toString().save("userName");
      Navigator.pop(context);
      routeStore.home_ui_route.push(context);
    } else {
      "登录失败".bbToast();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initForFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '名字',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: _login,
              child: Text('登录'),
            ),
            TextButton(
              onPressed: () {
                routeStore.register_route.push(context);
              },
              child: Text('注册'),
            ),
            TextButton(
              onPressed: () {
                routeStore.setting_route.push(context);
              },
              child: Text('设置'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initForFirst() async {
    _usernameController.text = "userName".getString(defaultValue: "");
    playManager.floating?.hideFloating();
    await playManager.clear();
    setState(() {});
  }
}
