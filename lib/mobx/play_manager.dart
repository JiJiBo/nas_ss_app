import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_floating/floating/assist/floating_slide_type.dart';
import 'package:flutter_floating/floating/floating.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mobx/mobx.dart';
import 'package:nas_ss_app/mf.dart';
import 'package:nas_ss_app/utils/ExtUtils.dart';
import '../view/FloatPage.dart';

// This is our generated file (we'll see this soon!)
part 'play_manager.g.dart';

// We expose this to be used throughout our project
class play_manager = _play_manager with _$play_manager;

final playManager = play_manager();

// Our store class
abstract class _play_manager with Store {
  @observable
  double currentSliderValue = 0.0;
  @observable
  double maxSliderValue = 0.0;
  final player = AudioPlayer();
  @observable
  String name = "";
  @observable
  String title = "";

  @observable
  bool isPlaying = false;

  Floating? floating = null;
  List urls = [];
  int currentIndex = 0;

  @action
  Future<void> startListener() async {
    var time = "time".getDouble(defaultValue: 0.0);
    player.currentIndexStream.listen(indexSteam);
    player.playerStateStream.listen(playstate);
    player.positionStream.listen(timeListener);
    player.playbackEventStream.listen(
        (event) {
          print("event.duration");
          print(event.duration);
        },
        onDone: () {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        },
        cancelOnError: true);
    var string = "play_url".getString(defaultValue: "");
    var currentIndex = "currentIndex".getInt(defaultValue: 0);
    name = "name".getString(defaultValue: "");
    if (string.isNotEmpty) {
      urls = json.decode(string.toString());
      await dealData();
      await player.pause();

      print("init time $time");
      setTitle();
      await player.seek(Duration(seconds: time.toInt()), index: currentIndex);
    }
    floating = floatingManager.createFloating(
        "1",
        Floating(
          FloatPage(),
          slideType: FloatingSlideType.onRightAndBottom,
          bottom: 100,
          isShowLog: false,
        ));
  }

  Future<void> dealData() async {
    List<AudioSource> play_list = [];
    int count = 0;
    for (var i in urls) {
      String t = getTitle(i);
      play_list.add(AudioSource.uri(
        Uri.parse(i),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: count.toString(),
          album: name,
          title: t,
          artUri: Uri.parse('icon/icon.jpeg'.toUrlFile),
        ),
      ));
      count++;
    }
    await player.setAudioSource(ConcatenatingAudioSource(children: play_list),
        preload: false);
    if (urls.isNotEmpty) {
      json.encode(urls).save("play_url");
    } else {}
  }

  String getTitle(i) {
    String t = i.substring(i.lastIndexOf("nas_time") + "nas_time".length);
    t = t.replaceAll(".txt", "").replaceAll(".mp3", "");
    return t;
  }

  Future<void> next() async {
    if (urls.isNotEmpty) {
      json.encode(urls).save("play_url");
    } else {}
    await player.seekToNext();
  }

  @action
  Future<void> play() async {
    await player.play();
  }

  @action
  void timeListener(Duration duration) {
    if (player.playerState.processingState == ProcessingState.ready) {
      currentSliderValue = duration.inSeconds.toDouble();
      maxSliderValue = player.duration?.inSeconds.toDouble() ??
          (player.bufferedPosition.inSeconds.toDouble());
      currentSliderValue.save("time");
      if (currentSliderValue != 0.0 && currentSliderValue % 3 == 0) {
        setTitle();
      }
    }
  }

  @action
  void setTitle() {
    isPlaying = player.playing;
    currentSliderValue.save("time");
    if (urls.length > currentIndex) {
      String url = urls[currentIndex];
      String t = getTitle(url);
      title = t.replaceAll(".txt", "").replaceAll(".mp3", "");
    }
  }

  @action
  void indexSteam(event) {
    currentIndex = player.currentIndex ?? 0;
    currentIndex.save("currentIndex");
    setTitle();
  }

  void playstate(event) {
    print("event.processingState");
    print(event.processingState);
    if (player.playerState.processingState == ProcessingState.ready) {}
  }

  @action
  Future<void> playPause() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play();
    }
    isPlaying = player.playing;
  }
}
