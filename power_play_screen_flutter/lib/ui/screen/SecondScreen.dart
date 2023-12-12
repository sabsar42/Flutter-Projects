import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final int sec = 20;
  final grayColor = Color.fromRGBO(218, 228, 231, 1.0);
  final fixedColor = Color.fromRGBO(73, 67, 62, 1.0);
  SelectController selectController = Get.put(SelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 28, 1.0),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<SelectController>(builder: (controller) {
            return GestureDetector(
              onTap: () {
                controller.updateValue(index, sec + index, 's');
              },
              child: Container(
                decoration: BoxDecoration(
                border: Border.all(
                  color: () {
                    if (controller.selectedItems[index].second == false) {
                      return fixedColor;
                    } else if (controller.selectedItems[index].second &&
                        controller.selectedItems[index].selectedScreen ==
                            's' &&
                        controller.selectedItems[index].first ==
                            sec + index) {
                      return Colors.yellowAccent;
                    } else {
                      return grayColor;
                    }
                  }(),
                ),),
                child: Center(
                  child: Text('${index+1}',
                  style: TextStyle(
                      color:Colors.white60,
                  ),),
                ),
              ),
            );
          });
        },
      ),
    );
  }


}

