import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mobx/route.dart';
import '../utils/AlertEdit.dart';
import '../utils/DioUtils.dart';

class SmallSayMidPage extends StatefulObserverWidget {
  @override
  _SmallSayMidPage createState() {
    return _SmallSayMidPage();
  }
}

class _SmallSayMidPage extends State<SmallSayMidPage> {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(bookinfo["name"] ?? "小说"),
          actions: [
            IconButton(
                onPressed: () {
                  routeStore.play_route.push(context);
                },
                icon: Icon(Icons.play_circle)),
            IconButton(
                onPressed: () {
                  alertEdit("输入书的链接,只能爬取qimao小说",
                      "https://www.qimao.com/shuku/", (v) {}, context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: EasyRefresh(
            onRefresh: refresh,
            child: ListView(
              children: [
                ListTile(
                  title: Text("BGM:${bgm["bgm"] ?? "--"}"),
                  subtitle: Text("人声:${voice["name"] ?? "--"}"),
                ),
                Visibility(
                    visible: isLink,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("网页链接:${bookinfo["link"] ?? "--"}"),
                          onTap: () async {
                            final Uri _url = Uri.parse(bookinfo["link"]);
                            if (!await launchUrl(_url)) {
                              'Could not launch $_url'.bbToast();
                            }
                          },
                        ),
                        ListTile(
                          title: Text("文本下载进度"),
                          subtitle: Text(
                              "${bookinfo["download_progress"] ?? 0}/${bookinfo["download_max"] ?? 0}"),
                        ),
                      ],
                    )),
                ListTile(
                  title: Text("解说进度"),
                  subtitle: Text(
                      "${bookinfo["conversion_progress"] ?? 0}/${bookinfo["conversion_max"] ?? 0}"),
                  trailing: Text("失败${bookinfo["conversion_fail"]}"),
                  onTap: () {
                    routeStore.small_say_detail_route.push(context, args: {
                      "bookid": bookid,
                      "get_step": 2,
                      "name": bookinfo["name"]
                    });
                  },
                ),
                ListTile(
                  title: Text("背景音乐进度"),
                  subtitle: Text(
                      "${bookinfo["add_back_progress"] ?? 0}/${bookinfo["add_back_max"] ?? 0}"),
                  trailing: Text("失败${bookinfo["add_back_fail"]}"),
                  onTap: () {
                    routeStore.small_say_detail_route.push(context, args: {
                      "bookid": bookid,
                      "get_step": 5,
                      "name": bookinfo["name"]
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    "更新",
                    style: TextStyle(color: Colors.green),
                  ),
                  subtitle: Text(bookinfo["last_updated"] ?? ""),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('不要频繁更新'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text('取消'),
                            ),
                            TextButton(
                              onPressed: () async {
                                var post = await update_novel(bookid);
                                if (post.isSuccess()) {
                                  "更新成功".bbToast();
                                  await refresh();
                                } else {
                                  "更新失败".bbToast();
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text('更新'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "清除",
                    style: TextStyle(color: Colors.amber),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('清除'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text('取消'),
                            ),
                            TextButton(
                              onPressed: () async {
                                SmartDialog.showLoading();
                                var post = await clear_novel(bookid);
                                if (post.isSuccess()) {
                                  "成功".bbToast();
                                  await refresh();
                                } else {
                                  "失败".bbToast();
                                }
                                SmartDialog.dismiss();
                                Navigator.of(context).pop();
                              },
                              child: Text('清除'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "删除",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('注意'),
                          content: Text('删除'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text('取消'),
                            ),
                            TextButton(
                              onPressed: () async {
                                SmartDialog.showLoading();
                                var post = await delete_novel(bookid);
                                if (post.isSuccess()) {
                                  "成功".bbToast();
                                  Navigator.pop(context);
                                } else {
                                  "失败".bbToast();
                                }
                                SmartDialog.dismiss();
                                Navigator.of(context).pop();
                              },
                              child: Text('删除'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                // ListTile(
                //   title: Text(
                //     "刷新",
                //     style: TextStyle(color: Colors.blueAccent),
                //   ),
                //   onTap: refresh,
                // ),
                // ListTile(
                //   title: Text(
                //     "停止",
                //     style: TextStyle(color: Colors.redAccent),
                //   ),
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: Text('注意'),
                //           content: Text('停止'),
                //           actions: [
                //             TextButton(
                //               onPressed: () async {
                //                 Navigator.of(context).pop();
                //               },
                //               child: Text('取消'),
                //             ),
                //             TextButton(
                //               onPressed: () async {
                //                 var post = await stop_novel(bookid);
                //                 if (post.isSuccess()) {
                //                   "成功".bbToast();
                //                   await refresh();
                //                 } else {
                //                   "失败".bbToast();
                //                 }
                //                 Navigator.of(context).pop();
                //               },
                //               child: Text('停止'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            )));
  }

  var bookinfo = {};
  var voice = {};
  var bgm = {};
  var bookid = 0;

  bool get isLink {
    return (bookinfo["type"] ?? "") == "link";
  }

  Future<void> initForFirst() async {
    await Duration.zero.delayed();
    bookid = context.getTheArg as int;
    await refresh();
  }

  Future<void> refresh() async {
    SmartDialog.showLoading();
    var post = await get_novel(bookid);
    if (post.isSuccess()) {
      bookinfo = post.getData();
    } else {
      "获取失败".bbToast();
      setState(() {});
      return;
    }
    print(bookinfo);
    var v = await get_a_voice(bookinfo["voice_id"]);
    if (v.isSuccess()) {
      voice = v.getData();
    } else {
      "get_a_voice失败".bbToast();
    }
    var b = await get_a_bgm(bookinfo["background_music_id"]);
    if (b.isSuccess()) {
      bgm = b.getData();
    } else {
      "get_a_bgm失败".bbToast();
    }
    SmartDialog.dismiss();
    setState(() {});
  }
}
