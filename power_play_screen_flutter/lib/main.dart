import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/ui/screen/play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),

      home: PlayScreen(),
    );
  }
}
