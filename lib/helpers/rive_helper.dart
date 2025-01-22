import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveHelper {

  static RiveFile? mainFile;


  static RiveFile? mascotFile;
  static RiveFile? buttonsFile;
  static RiveFile? miscFile;

  static const String defaultName = 'Mr.';

  static Future<void> loadRive() async {
    String path = './assets/animations/mascot.riv';
    await RiveFile.initialize();
    mainFile = RiveFile.import(await rootBundle.load(path));
  }

  static Future<void> loadRiveFiles() async {
    String buttonsPath = './assets/animations/rivebuttons.riv';
    String mascotPath = './assets/animations/rivemascot.riv';
    String miscPath = './assets/animations/rivemisc.riv';

    final bundles = await Future.wait([
      rootBundle.load(buttonsPath),
      rootBundle.load(mascotPath),
      rootBundle.load(miscPath),
    ]);

    await RiveFile.initialize();
    buttonsFile = RiveFile.import(bundles[0]);
    mascotFile = RiveFile.import(bundles[1]);
    miscFile = RiveFile.import(bundles[2]);
  }
}