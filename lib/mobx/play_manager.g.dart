// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$play_manager on _play_manager, Store {
  late final _$currentSliderValueAtom =
      Atom(name: '_play_manager.currentSliderValue', context: context);

  @override
  double get currentSliderValue {
    _$currentSliderValueAtom.reportRead();
    return super.currentSliderValue;
  }

  @override
  set currentSliderValue(double value) {
    _$currentSliderValueAtom.reportWrite(value, super.currentSliderValue, () {
      super.currentSliderValue = value;
    });
  }

  late final _$maxSliderValueAtom =
      Atom(name: '_play_manager.maxSliderValue', context: context);

  @override
  double get maxSliderValue {
    _$maxSliderValueAtom.reportRead();
    return super.maxSliderValue;
  }

  @override
  set maxSliderValue(double value) {
    _$maxSliderValueAtom.reportWrite(value, super.maxSliderValue, () {
      super.maxSliderValue = value;
    });
  }

  late final _$nameAtom = Atom(name: '_play_manager.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$titleAtom = Atom(name: '_play_manager.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: '_play_manager.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$startListenerAsyncAction =
      AsyncAction('_play_manager.startListener', context: context);

  @override
  Future<void> startListener() {
    return _$startListenerAsyncAction.run(() => super.startListener());
  }

  late final _$playAsyncAction =
      AsyncAction('_play_manager.play', context: context);

  @override
  Future<void> play() {
    return _$playAsyncAction.run(() => super.play());
  }

  late final _$playPauseAsyncAction =
      AsyncAction('_play_manager.playPause', context: context);

  @override
  Future<void> playPause() {
    return _$playPauseAsyncAction.run(() => super.playPause());
  }

  late final _$_play_managerActionController =
      ActionController(name: '_play_manager', context: context);

  @override
  void timeListener(Duration duration) {
    final _$actionInfo = _$_play_managerActionController.startAction(
        name: '_play_manager.timeListener');
    try {
      return super.timeListener(duration);
    } finally {
      _$_play_managerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle() {
    final _$actionInfo = _$_play_managerActionController.startAction(
        name: '_play_manager.setTitle');
    try {
      return super.setTitle();
    } finally {
      _$_play_managerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void indexSteam(dynamic event) {
    final _$actionInfo = _$_play_managerActionController.startAction(
        name: '_play_manager.indexSteam');
    try {
      return super.indexSteam(event);
    } finally {
      _$_play_managerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentSliderValue: ${currentSliderValue},
maxSliderValue: ${maxSliderValue},
name: ${name},
title: ${title},
isPlaying: ${isPlaying}
    ''';
  }
}
