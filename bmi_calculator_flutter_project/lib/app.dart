import 'package:bmi_calculator_flutter_project/screen/bmi_screen.dart';
import 'package:bmi_calculator_flutter_project/controller/switch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BmiScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(SwitchController());
      }),
    );
  }
}