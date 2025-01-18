import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/models/enums.dart';

class MascotHat extends StatefulWidget {

  final MascotHatOptions hat;
  final Function(MascotHatOptions hat) onHatSelected;
  const MascotHat({super.key, required this.hat, required this.onHatSelected});

  @override
  State<MascotHat> createState() => _MascotHatState();
}

class _MascotHatState extends State<MascotHat> {

  late RiveAnimation anim;
  late StateMachineController ctrl;

  @override 
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(
      RiveHelper.mainFile!,
      artboard: '${widget.hat.name}hat',
      stateMachines: ['${widget.hat.name}hat'],
      fit: BoxFit.fitWidth,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, '${widget.hat.name}hat')!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        widget.onHatSelected(widget.hat);
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: anim,
      ),
    );
  }
}