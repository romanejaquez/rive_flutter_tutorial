import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/models/enums.dart';
import 'package:rive_app/providers/mascot_providers.dart';
import 'package:rive_app/widgets/mascot.dart';
import 'package:rive_app/widgets/mascot_hat_selection.dart';
import 'package:rive_app/widgets/mascot_icon.dart';
import 'package:rive_app/widgets/mascot_name_form.dart';
import 'package:rive_app/widgets/mascot_title.dart';
import 'package:rive_app/widgets/mascotbutton.dart';

class MascotPage extends StatelessWidget {
  const MascotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromARGB(255, 15, 159, 216),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer(
                  builder: (context, ref, child) {

                    final mascotName = ref.watch(selectedMascotNameProvider);

                    return MascotTitle(
                      key: ValueKey(mascotName.hashCode),
                      name: mascotName,
                    );
                  }
                ),
                
                Consumer(
                  builder: (context, ref, child) {

                    final mascotAction = ref.watch(selectedMascotActionProvider);
                    final hat = ref.watch(selectedMascotHatProvider);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.75,
                          height: 300,
                          child: Mascot(
                            action: mascotAction, 
                            hat: hat,
                          ),
                        ),
                                  
                        SizedBox(height: 32),
                        Center(
                          child: MascotHatSelection(
                            hatOption: hat,
                            onHatSelected: (value) {
                              ref.read(selectedMascotHatProvider.notifier).updateHat(value);
                              ref.read(selectedMascotActionProvider.notifier).updateAction(MascotActions.none);
                            },
                          )
                        ),
                        SizedBox(height: 32),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MascotButton(action: MascotActions.jump,
                              onAction: (action) {
                                ref.refresh(selectedMascotActionProvider.notifier).updateAction(action);
                              },
                            ),
                            MascotButton(action: MascotActions.wave,
                              onAction: (action) {
                                ref.refresh(selectedMascotActionProvider.notifier).updateAction(action);
                              },
                            ),
                          ].animate(
                            interval: 0.25.seconds,
                          ).slideY(
                            begin: 0.75, end: 0,
                            curve: Curves.easeInOut,
                            duration: 0.5.seconds,
                          ).fadeIn(
                            curve: Curves.easeInOut,
                            duration: 0.5.seconds,
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: MascotIcon(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctxt) {
              return Consumer(
                builder: (context, ref, child) {
                  return MascotNameForm(
                    onUpdatedName: (value) {
                      ref.read(selectedMascotNameProvider.notifier).updateName(
                        value.isNotEmpty ? value : RiveHelper.defaultName);
                      Navigator.of(ctxt).pop();
                    }
                  );
                }
              );
            });
        },
      ).animate(
        delay: 1.seconds
      ).scaleXY(
        begin: 0.25, end: 1,
        curve: Curves.elasticInOut,
        duration: 1.seconds,
      ).fadeIn(
        curve: Curves.elasticInOut,
        duration: 1.seconds,
      ),
    );
  }
}