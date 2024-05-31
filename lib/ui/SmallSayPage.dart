import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mobx/play_manager.dart';
import '../mobx/route.dart';
import '../utils/AlertEdit.dart';
import '../utils/DioUtils.dart';

class SmallSayPage extends StatefulObserverWidget {
  @override
  _SmallSayPage createState() {
    return _SmallSayPage();
  }
}

class _SmallSayPage extends State<SmallSayPage> {
  @override
  void initState() {
    initForFirst();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("小说"),
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
            onLoad: loading,
            child: ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: list.length,
            )));
  }

  var list = [];

  Future<void> initForFirst() async {
    await Duration.zero.delayed();
    floatingManager.closeAllFloating();
    playManager.floating?.open(context);
    await refresh();
  }

  var page = 1;
  var pages = [];

  Future<void> refresh() async {
    page = 1;
    pages.clear();
    await getBook(page);
  }

  Future<void> loading() async {
    page += 1;
    await getBook(page);
  }

  Future<void> getBook(page) async {
    var post = await get_all_novels(page);
    if (post.isSuccess()) {
      list = post.getData()["results"] as List;
    } else {}
    setState(() {});
  }

  Widget? itemBuilder(BuildContext context, int index) {
    var book = list[index];
    return ListTile(
      title: Text(book["name"]),
      onTap: () {
        routeStore.small_say_mid_route.push(context, args: book["id"]);
      },
    );
  }
}
