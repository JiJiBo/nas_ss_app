import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/AlertEdit.dart';
import '../utils/DioUtils.dart';

class CreatNewBookTxtPage extends StatefulObserverWidget {
  String hint;
  Function(String) call;

  CreatNewBookTxtPage(this.hint, this.call);

  @override
  _CreatNewBookTxtPage createState() {
    return _CreatNewBookTxtPage();
  }
}

class _CreatNewBookTxtPage extends State<CreatNewBookTxtPage> {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  List voice = [];
  List bgm = [];
  String path = "";
  String? fileName;

  Uint8List? fileBytes;

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
                        child: ListTile(
                      title: Text(fileName ?? "文件"),
                      subtitle: Text(path),
                      onTap: () async {
                        final result = await FilePicker.platform
                            .pickFiles(allowCompression: false);

                        if (result != null) {
                          if (kIsWeb) {
                            if (result != null && result.files.isNotEmpty) {
                              fileBytes = result.files.first.bytes;
                              fileName = result?.files.first.name.substring(
                                  0, result?.files.first.name.lastIndexOf("."));
                            }
                          } else {
                            path = result?.files.single.path ?? "";
                            fileName = result?.files.first.name.substring(
                                0, result?.files.first.name.lastIndexOf("."));
                          }
                        } else {}
                        setState(() {});
                      },
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
                        onPressed: confirm,
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

    setState(() {});
  }

  Future<void> confirm() async {
    if (kIsWeb) {
      if (fileBytes == null) {
        return;
      }
      print("add_novel_by_txtKWeb");
      addByBytes();
    } else if (path.isNotEmpty) {
      SmartDialog.showLoading();
      try {
        var post = await add_novel_by_txt(
            fileName ?? "no name",
            path,
            voice[currentVoiceIndex]?["value"].toString() ?? "",
            bgm[currentBGMIndex]?["path"].toString() ?? "",
            voice[currentVoiceIndex]?["id"].toString() ?? "",
            bgm[currentBGMIndex]?["id"].toString() ?? "");

        print(post.data);
        if (post.isSuccess()) {
          SmartDialog.dismiss();
        } else {
          "创建失败".bbToast();
        }
      } catch (e) {
        print(e);
      } finally {
        SmartDialog.dismiss(status: SmartStatus.loading);
      }
    }
  }

  Future<void> addByBytes() async {
    var post = await add_novel_by_txtByBytes(
        "from app",
        fileBytes,
        voice[currentVoiceIndex]?["value"].toString() ?? "",
        bgm[currentBGMIndex]?["path"].toString() ?? "",
        voice[currentVoiceIndex]?["id"].toString() ?? "",
        bgm[currentBGMIndex]?["id"].toString() ?? "");
    if (post.isSuccess()) {
      SmartDialog.dismiss();
    } else {
      "创建失败".bbToast();
    }
  }
}
