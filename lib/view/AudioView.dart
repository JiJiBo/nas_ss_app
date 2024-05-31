import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nas_ss_app/view/seekbar.dart';
import 'package:rxdart/rxdart.dart';

import '../mobx/play_manager.dart';

class AudioView extends StatefulObserverWidget {
  AudioView();

  @override
  _AudioViewState createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initForFirst();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Future<void> initForFirst() async {
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          playManager.player.positionStream,
          playManager.player.bufferedPositionStream,
          playManager.player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(playManager.title),
        StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBar(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: (newPosition) {
                playManager.player.seek(newPosition);
              },
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon:
                  Icon(playManager.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: playManager.playPause,
            ),
          ],
        ),
      ],
    );
  }
}
