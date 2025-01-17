import 'package:flutter/material.dart';
import 'package:rive_app/pages/landing_page.dart';
import 'package:rive_app/pages/mascot_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LandingPage(),
        '/mascot': (context) => MascotPage(),
      },
    );
  }
}
