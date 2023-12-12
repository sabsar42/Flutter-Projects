import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';
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

        useMaterial3: true,
      ),

      home: const PlayScreen(),
      initialBinding: GetxDependencyBinder(),
    );
  }
}
class GetxDependencyBinder extends Bindings{

  @override
  void dependencies() {
    Get.put(SelectController());
  }

}
