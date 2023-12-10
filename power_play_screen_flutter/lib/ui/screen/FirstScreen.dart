import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/ui/screen/selectController.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
