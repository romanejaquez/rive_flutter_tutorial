import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveHelper {

  static RiveFile? mainFile;
  static const String defaultName = 'Mr.';

  static Future<void> loadRive({ String path = './assets/animations/mascot.riv'}) async {
    await RiveFile.initialize();
    mainFile = RiveFile.import(await rootBundle.load(path));
  }
}