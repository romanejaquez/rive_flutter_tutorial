import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rive_app/helpers/rive_helper.dart';
import 'package:rive_app/widgets/mascot.dart';
import 'package:rive_app/widgets/mascot_title.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late Timer pageTimer;

  @override 
  void initState() {
    super.initState();

    pageTimer = Timer(const Duration(seconds: 6), () {
      Navigator.pushNamed(context, '/mascot');
    });
  }

  @override  
  void dispose() {
    pageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: RiveHelper.loadRive(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
                
            return Stack(
              children: [

                Positioned(
                  left: 0, right: 0,
                  top: 200,
                  child: MascotTitle(),
                ).animate()
                .scaleXY(
                  alignment: Alignment.bottomCenter,
                  begin: 0.5, end: 1.5,
                  curve: Curves.easeInOut,
                  duration: 1.seconds,
                ).fadeIn(
                  curve: Curves.easeInOut,
                  duration: 1.seconds,
                ),

                Positioned(
                  top: 0,
                  bottom: -500,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.scale(scale: 1.8, child: Mascot()),
                  ),
                ).animate()
                .slideY(
                  begin: 0.45, end: 0,
                  curve: Curves.easeInOut,
                  duration: 2.seconds,
                )
                .fadeIn(
                  curve: Curves.easeInOut,
                  duration: 2.seconds,
                )
              ],
            );
          }
                
          return CircularProgressIndicator.adaptive();
        }
      ),
    );
  }
}