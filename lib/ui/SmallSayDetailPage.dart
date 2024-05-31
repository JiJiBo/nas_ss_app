import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';

import '../mobx/play_manager.dart';
import '../mobx/route.dart';
import '../utils/DioUtils.dart';

class SmallSayDetailPage extends StatefulObserverWidget {
  @override
  _SmallSayDetailPage createState() {
    return _SmallSayDetailPage();
  }
}

class _SmallSayDetailPage extends State<SmallSayDetailPage> {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  var myScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          actions: [
            IconButton(
                onPressed: () {
                  routeStore.play_route.push(context);
                },
                icon: Icon(Icons.play_circle))
          ],
        ),
        body: EasyRefresh(
            onRefresh: refresh,
            onLoad: loading,
            child: DraggableScrollbar.rrect(
                controller: myScrollController,
                child: ListView.builder(
                  controller: myScrollController,
                  itemBuilder: itemBuilder,
                  itemCount: pages.length,
                ))));
  }

  var bookid = 0;
  var page = 1;
  var name = "小说";
  var get_step = 2;
  var pages = [];

  Future<void> initForFirst() async {
    await Duration.zero.delayed();
    var bookinfo = context.getTheArg as Map;
    bookid = bookinfo["bookid"];
    get_step = bookinfo["get_step"];
    name = bookinfo["name"];
    await refresh();
    setState(() {});
  }

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
    var post = await get_filtered_books(page, bookid, get_step);
    if (post.isSuccess()) {
      pages.addAll(post.getData()["results"]);
    }
    setState(() {});
  }

  Widget? itemBuilder(BuildContext context, int index) {
    var title = pages[index];
    return ListTile(
      title: Text(title["name"] ?? "--"),
      trailing: IconButton(
          onPressed: () async {
            routeStore.play_route.push(context);
            playManager.name = name;
            playManager.urls.clear();
            for (int i = index; i < pages.length; i++) {
              String path = pages[i]["path"];
              var url = path.toMp3File;
              print(url);
              playManager.urls.add(url);
              await playManager.dealData();
            }
            playManager.play();
            playManager.name = name.toString();
            name.toString().save("name");
            setState(() {});
          },
          icon: Icon(
            Icons.play_circle,
            color: Colors.blueAccent,
          )),
    );
  }
}
