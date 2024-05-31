import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nas_ss_app/ui/WelcomePage.dart';
import 'package:nas_ss_app/mobx/play_manager.dart';
import 'package:nas_ss_app/ui/HomePage.dart';
import 'package:nas_ss_app/ui/LoginPage.dart';
import 'package:nas_ss_app/ui/PlayPage.dart';
import 'package:nas_ss_app/ui/RegisterPage.dart';
import 'package:nas_ss_app/ui/SettingPage.dart';
import 'package:nas_ss_app/ui/SmallSayDetailPage.dart';
import 'package:nas_ss_app/ui/SmallSayMidPage.dart';
import 'package:nas_ss_app/ui/SmallSayPage.dart';
import 'package:nas_ss_app/ui/UserPage.dart';

import 'mf.dart';
import 'mobx/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBengBengDefault(appName: "nasTools");
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
  await initForFirst();
}

Future<void> initForFirst() async {
  routeStore.url = "ipv46".getString(defaultValue: "ss.nasneo.online");
  routeStore.fileUrl =
      "fileUrl".getString(defaultValue: "mf.file.nasneo.online");
  routeStore.port = "port".getString(defaultValue: "");
  routeStore.filePort = "filePort".getString(defaultValue: "7777");
  await playManager.startListener();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = {
    routeStore.welcome_ui_route: (context, {arguments}) => WelcomePage(),
    routeStore.home_ui_route: (context, {arguments}) => HomePage(),
    routeStore.small_say_detail_route: (context, {arguments}) =>
        SmallSayDetailPage(),
    routeStore.small_say_route: (context, {arguments}) => SmallSayPage(),
    routeStore.play_route: (context, {arguments}) => PlayPage(),
    routeStore.small_say_mid_route: (context, {arguments}) => SmallSayMidPage(),
    routeStore.setting_route: (context, {arguments}) => SettingPage(),
    routeStore.login_route: (context, {arguments}) => LoginPage(),
    routeStore.register_route: (context, {arguments}) => RegisterPage(),
    routeStore.user_route: (context, {arguments}) => UserPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var FlutterSmartDialogInit = FlutterSmartDialog.init();
    var botToastInit = BotToastInit();
    return MaterialApp(
      title: 'NasTools',
      routes: routes,
      builder: (context, child) {
        child = botToastInit(context, child);
        child = FlutterSmartDialogInit(context, child);
        return child;
      },
      navigatorObservers: [
        defaultLifecycleObserver,
        FlutterSmartDialog.observer,
        BotToastNavigatorObserver(),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
