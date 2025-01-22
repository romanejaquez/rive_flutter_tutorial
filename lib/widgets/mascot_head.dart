import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/helpers/rive_helper.dart';


class MascotHead extends StatefulWidget {

  const MascotHead({super.key});

  @override
  State<MascotHead> createState() => _MascotHeadState();
}

class _MascotHeadState extends State<MascotHead> {

  late RiveAnimation anim;
  late StateMachineController ctrl;
  late TextValueRun mascotName;

  @override 
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(
      RiveHelper.mascotFile!,
      artboard: 'titlehead',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'titlehead')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 180,
      child: anim,
    );
  }
}