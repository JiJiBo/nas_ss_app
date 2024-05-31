import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/mf.dart';

import '../mobx/route.dart';

class SettingPage extends StatefulObserverWidget {
  @override
  _SettingPage createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _filecontroller = TextEditingController();
  TextEditingController _fileport = TextEditingController();
  TextEditingController _port = TextEditingController();
  bool isv6 = false;
  bool isv6file = false;

  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  @override
  void dispose() {
    _controller.dispose();
    _port.dispose();
    _filecontroller.dispose();
    _fileport.dispose();
    super.dispose();
  }

  void _saveInput() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('注意'),
          content: Text('保存链接'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                String inputText = _controller.text;
                if (isv6) {
                  inputText = "[${inputText}]";
                }
                isv6.save("isv6");
                // 在这里处理保存逻辑，例如打印输入内容
                inputText.save("ipv46");
                "已保存".bbToast();
                print("输入内容: $inputText");
                Navigator.pop(context);
              },
              child: Text('更新'),
            ),
          ],
        );
      },
    );
  }

  void filePortSave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('注意'),
          content: Text('保存'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                String inputText = _fileport.text;
                // 在这里处理保存逻辑，例如打印输入内容
                inputText.save("filePort");
                "已保存".bbToast();
                print("输入内容: $inputText");
                Navigator.pop(context);
              },
              child: Text('更新'),
            ),
          ],
        );
      },
    );
  }

  void fileUrlSave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('注意'),
          content: Text('保存'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                String inputText = _filecontroller.text;
                if (isv6file) {
                  inputText = "[${inputText}]";
                }
                // 在这里处理保存逻辑，例如打印输入内容
                inputText.save("fileUrl");
                "已保存".bbToast();
                print("输入内容: $inputText");
                Navigator.pop(context);
              },
              child: Text('更新'),
            ),
          ],
        );
      },
    );
  }

  void portSave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('注意'),
          content: Text('保存'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                String inputText = _port.text;
                // 在这里处理保存逻辑，例如打印输入内容
                inputText.save("port");
                "已保存".bbToast();
                print("输入内容: $inputText");
                Navigator.pop(context);
              },
              child: Text('更新'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("设置"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "输入链接",
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                  title: Text("ipv6"),
                  value: isv6,
                  onChanged: (v) {
                    isv6 = v!;
                    setState(() {});
                  }),
              ElevatedButton(
                onPressed: _saveInput,
                child: Text("保存"),
              ),
              TextField(
                controller: _port,
                decoration: InputDecoration(
                  labelText: "端口",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: portSave,
                child: Text("保存"),
              ),
              TextField(
                controller: _filecontroller,
                decoration: InputDecoration(
                  labelText: "输入文件链接",
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                  title: Text("ipv6"),
                  value: isv6file,
                  onChanged: (v) {
                    isv6file = v!;
                    setState(() {});
                  }),
              ElevatedButton(
                onPressed: fileUrlSave,
                child: Text("保存"),
              ),
              TextField(
                controller: _fileport,
                decoration: InputDecoration(
                  labelText: "文件端口",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: filePortSave,
                child: Text("保存"),
              ),
            ],
          ),
        ));
  }

  void initForFirst() {
    isv6 = "isv6".getBool(defaultValue: false);
    isv6file = "isv6file".getBool(defaultValue: false);
    _controller.text = "ipv46".getString(defaultValue: routeStore.url);
    _port.text = "port".getString(defaultValue: routeStore.port);
    _fileport.text = "filePort".getString(defaultValue: routeStore.filePort);
    _filecontroller.text =
        "fileUrl".getString(defaultValue: routeStore.fileUrl);
    if (isv6) {
      _controller.text =
          _controller.text.substring(1, _controller.text.length - 1);
    }
    if (isv6file) {
      _filecontroller.text =
          _filecontroller.text.substring(1, _filecontroller.text.length - 1);
    }
    setState(() {});
  }
}
