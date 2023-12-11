import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_play_screen_flutter/ui/screen/selectController.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final fixedColor = Color.fromRGBO(8, 8, 45, 1.0);
  SelectController selectController = Get.put(SelectController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {

          return GestureDetector(
            onTap: () {
              setState(() {
                selectController.selectedItems[index] = !selectController.selectedItems[index];
              });
            },
            child: Container(
              color: selectController.selectedItems[index] ? Colors.red : fixedColor,
              child: Center(
                child: Text('${index}'),
              ),
            ),
          );
        },
      ),
    );
  }
}