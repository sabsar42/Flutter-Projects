import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final int fir = 10;
  final grayColor = Color.fromRGBO(218, 228, 231, 1.0);
  final fixedColor = Color.fromRGBO(73, 67, 62, 1.0);
  bool tap = false;
  SelectController selectController = Get.find<SelectController>();

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
                controller.updateValue(index, fir + index, 'f');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: () {
                      if (controller.selectedItems[index].second == false) {
                        return fixedColor;
                      } else if (controller.selectedItems[index].second &&
                          controller.selectedItems[index].selectedScreen ==
                              'f' &&
                          controller.selectedItems[index].first ==
                              fir + index) {
                        return Colors.yellowAccent;
                      } else {
                        return grayColor;
                      }
                    }(),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
