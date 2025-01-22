import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/models/enums.dart';

class Mascot extends StatefulWidget {

  final MascotActions? action;
  final MascotHatOptions? hat;
  const Mascot({super.key, this.action, this.hat});

  @override
  State<Mascot> createState() => _MascotState();
}

class _MascotState extends State<Mascot> {

  late RiveAnimation anim;
  late StateMachineController ctrl;
  bool isLoadingComplete = false;

  Map<MascotHatOptions, SMIBool> hatMap = {};

  Map<MascotActions, SMITrigger> actionMap = {};

  @override 
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(
      RiveHelper.mascotFile!,
      artboard: 'mascot',
      fit: BoxFit.contain,
      onInit: onRiveInit,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'mascot')!;
    ab.addController(ctrl);
    

    final mascotActions = MascotActions.values.where((a) => a != MascotActions.none && a != MascotActions.name).toList();
    for(var action in mascotActions) {
      actionMap[action] = ctrl.findSMI(action.name) as SMITrigger;
    }

    for(var hat in MascotHatOptions.values.where((h) => h != MascotHatOptions.none)) {
      hatMap[hat] = ctrl.findInput<bool>(hat.name) as SMIBool;
    }
    
    setState(() {
      isLoadingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoadingComplete) {
      if (widget.action != null && widget.action != MascotActions.none) {
        actionMap[widget.action]!.fire();
      }
      
      if (widget.hat != null && widget.hat != MascotHatOptions.none) {
        for(var hatEntry in hatMap.entries) {
          if (hatEntry.key == widget.hat) {
            hatEntry.value.change(true);
          } else {
            hatEntry.value.change(false);
          }
        }
      }
    }

    return SizedBox(
      child: anim
    );
  }
}