import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/helpers/rive_helper.dart';

extension _TextExtension on Artboard {
  TextValueRun? textRun(String name) => component<TextValueRun>(name);
}

class MascotTitle extends StatefulWidget {

  final String name;
  const MascotTitle({super.key, this.name = RiveHelper.defaultName});

  @override
  State<MascotTitle> createState() => _MascotTitleState();
}

class _MascotTitleState extends State<MascotTitle> {

  late RiveAnimation anim;
  late StateMachineController ctrl;
  late TextValueRun mascotName;

  @override 
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(
      RiveHelper.miscFile!,
      artboard: 'allbubblestitle',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'allbubblestitle')!;
    ab.addController(ctrl);

    mascotName = ab.textRun('mascotname')!;
    mascotName.text = widget.name;

    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: anim,
    );
  }
}