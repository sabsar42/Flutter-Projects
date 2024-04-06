import 'package:bmi_calculator_flutter_project/screen/bmi_screen.dart';
import 'package:bmi_calculator_flutter_project/controller/switch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class BmiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(SwitchController());
      }),
    );
  }
}