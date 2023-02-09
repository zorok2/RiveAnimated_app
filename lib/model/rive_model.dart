import 'package:rive/rive.dart';

class RiveModel {
  final String src, artboard, stateMachineName;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

class RiveAssets {
  final String src;
  final String artBoard, stateMachineName, title;
  late SMIBool? input;

  RiveAssets(this.src,
      {required this.artBoard,
      required this.stateMachineName,
      required this.title,
      this.input});
  set setInput(SMIBool input) {
    this.input = input;
  }
}
