import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/helpers/rive_helper.dart';


class MascotIcon extends StatefulWidget {

  final String name;
  const MascotIcon({super.key, this.name = 'Mascot'});

  @override
  State<MascotIcon> createState() => _MascotIconState();
}

class _MascotIconState extends State<MascotIcon> {

  late RiveAnimation anim;
  late StateMachineController ctrl;

  @override 
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(
      RiveHelper.mainFile!,
      artboard: 'mascoticon',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'mascoticon')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: anim,
    );
  }
}