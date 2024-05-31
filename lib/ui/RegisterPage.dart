import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../utils/DioUtils.dart';

class RegisterPage extends StatefulObserverWidget {
  @override
  _RegisterPage createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    SmartDialog.showLoading();
    try {
      // 在这里编写注册逻辑，可以将用户名和密码发送到后端进行处理
      String username = _usernameController.text;
      String password = _passwordController.text;
      var post = await register(username, password);
      if (post.isSuccess()) {
        "注册成功".bbToast();
      } else {
        "注册失败${post.getData()["error"]}".bbToast();
      }
    } catch (e) {
      print(e);
    }
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
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
              onPressed: _register,
              child: Text('注册'),
            ),
          ],
        ),
      ),
    );
  }
}
