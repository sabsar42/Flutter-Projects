import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final int thi = 30;
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
                controller.updateValue(index, thi + index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedItems[index].second == false
                        ? fixedColor
                        : (controller.selectedItems[index].second &&
                                controller.selectedItems[index].first ==
                                    thi + index)
                            ? Colors.yellowAccent
                            : grayColor,
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
