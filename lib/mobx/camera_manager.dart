import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../view/OutCameraView.dart';

// This is our generated file (we'll see this soon!)
part 'camera_manager.g.dart';

// We expose this to be used throughout our project
class CameraManager = _CameraManager with _$CameraManager;

final CameraManager cameraManagerStore = CameraManager();

// Our store class
abstract class _CameraManager with Store {

}
