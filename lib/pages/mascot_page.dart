import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/models/enums.dart';
import 'package:rive_app/widgets/mascot.dart';
import 'package:rive_app/widgets/mascot_hat.dart';
import 'package:rive_app/widgets/mascot_hat_selection.dart';
import 'package:rive_app/widgets/mascot_icon.dart';
import 'package:rive_app/widgets/mascot_name_form.dart';
import 'package:rive_app/widgets/mascot_title.dart';
import 'package:rive_app/widgets/mascotbutton.dart';

class MascotPage extends StatefulWidget {
  const MascotPage({super.key});

  @override
  State<MascotPage> createState() => _MascotPageState();
}

class _MascotPageState extends State<MascotPage> {

  late ValueNotifier<MascotActions> action;
  late ValueNotifier<MascotHatOptions> hat;
  late ValueNotifier<String> mascotName;

  @override 
  void initState() {
    super.initState();

    action = ValueNotifier(MascotActions.none);
    hat = ValueNotifier(MascotHatOptions.none);
    mascotName = ValueNotifier(RiveHelper.defaultName);
  }
  
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

          ValueListenableBuilder(
            valueListenable: hat,
            builder: (context, hat, child) {
            
              action.value = MascotActions.none;

              return ValueListenableBuilder(
                valueListenable: action,
                builder: (context, action, child) {

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: mascotName,
                          builder: (context, name, child) {
                            return MascotTitle(
                              key: ValueKey(name.hashCode),
                              name: name);
                          }
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.75,
                          height: 300,
                          child: Mascot(
                            action: action, hat: hat,
                          ),
                        ),
                  
                        SizedBox(height: 32),
                        Center(
                          child: MascotHatSelection(
                            hatOption: hat,
                            onHatSelected: (value) {
                              this.hat.value = value;
                            },
                          )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MascotButton(action: MascotActions.jump,
                              onAction: (action) {
                                this.action.value = action;
                              },
                            ),
                            MascotButton(action: MascotActions.wave,
                              onAction: (action) {
                                this.action.value = action;
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
                    ),
                  );
                },
                child: child,
              );
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: MascotIcon(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctxt) {
              return MascotNameForm(
                name: mascotName,
                onUpdatedName: (value) {
                  mascotName.value = value.isNotEmpty ? value : RiveHelper.defaultName;
                  Navigator.of(ctxt).pop();
                }
              );
            });
        },
      ),
    );
  }
}