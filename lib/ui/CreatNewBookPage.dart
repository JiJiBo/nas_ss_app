import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/AlertEdit.dart';
import '../utils/DioUtils.dart';

class CreatNewBookPage extends StatefulObserverWidget {
  String hint;
  String msg;
  Function(String) call;

  CreatNewBookPage(this.hint, this.msg, this.call);

  @override
  _CreatNewBookPage createState() {
    return _CreatNewBookPage();
  }
}

class _CreatNewBookPage extends State<CreatNewBookPage> {
  @override
  void initState() {
    super.initState();
    _controller.text = widget.msg;
    initForFirst();
  }

  List voice = [];
  List bgm = [];
  TextEditingController _controller = TextEditingController();

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
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                  color: Color(0xFF1B1D4C),
                ),
                title: Text(
                  '${widget.hint}',
                  style: TextStyle(color: Color(0xFF1B1D4C), fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.hint}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF222222),
                              height: 2),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextField(
                          controller: _controller,
                          maxLines: 10,
                          minLines: 1,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: Color(0xFFDBDBDB)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFFEFEFF),
                          ),
                        ),
                        _controller.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  _controller.clear();
                                },
                              )
                            : Container(), // 如果输入框为空则不显示清空按钮
                      ],
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: getItem,
                            itemCount: voice.length,
                          ),
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: getBGM,
                            itemCount: bgm.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () async {
                    final Uri _url = Uri.parse('https://www.qimao.com/shuku/');
                    if (!await launchUrl(_url)) {
                      'Could not launch $_url'.bbToast();
                    }
                  },
                  icon: Icon(
                    Icons.web_rounded,
                    color: Color(0xFF037AFF),
                  )),
              Container(
                  child: TextButton(
                      style: noPaddingBS,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container())),
              Expanded(child: Container()),
              Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width - 32,
                    decoration: BoxDecoration(
                        color: Color(0xFF037AFF),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextButton(
                        style: noPaddingBS,
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            var post = await add_novel(
                                "from app",
                                _controller.text,
                                voice[currentVoiceIndex]?["value"] ?? "",
                                bgm[currentBGMIndex]?["path"] ?? "",
                                voice[currentVoiceIndex]?["id"] ?? "",
                                bgm[currentBGMIndex]?["id"] ?? "");
                            print(post.data);
                            if (post.isSuccess()) {
                              SmartDialog.dismiss();
                            } else {
                              "创建失败".bbToast();
                            }
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 32,
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextButton(
                        style: noPaddingBS,
                        onPressed: () {
                          SmartDialog.dismiss();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color(0xFF222222),
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 25,
              ),
            ],
          ),
        ));
  }

  int currentVoiceIndex = 0;

  Widget getItem(BuildContext context, int index) {
    var v = voice[index];
    return TextButton(
        onPressed: () {
          currentVoiceIndex = index;
          setState(() {});
        },
        child: Text(
          v["name"],
          style: TextStyle(
              color: currentVoiceIndex == index ? Colors.blue : Colors.black),
        ));
  }

  int currentBGMIndex = 0;

  Widget getBGM(BuildContext context, int index) {
    var v = bgm[index];
    return TextButton(
        onPressed: () {
          currentBGMIndex = index;
          setState(() {});
        },
        child: Text(
          v["bgm"],
          style: TextStyle(
              color: currentBGMIndex == index ? Colors.blue : Colors.black),
        ));
  }

  Future<void> initForFirst() async {
    var v = await get_all_voice();
    if (v.isSuccess()) {
      voice.addAll(v.getData()["results"]);
    } else {}
    var b = await get_all_bgm();
    if (b.isSuccess()) {
      bgm.addAll(b.getData()["results"]);
    } else {}
    print(voice);
    print(bgm);
    setState(() {});
  }
}
