import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/switch_controller.dart';
import '../utils/dropdown_utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
    required this.heightFromUser,
    required this.weightFromUser,
  }) : super(key: key);

  final String heightFromUser;
  final String weightFromUser;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SwitchController switchController = Get.find<SwitchController>();
  String heightUnit = 'ft';
  String weightUnit = 'kg'; 
  String classificationDropDownValue = 'WHO';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        toolbarHeight: 70,
        leading: const BackButton(),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<SwitchController>(
            builder: (switchController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Evaluation',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  GetBuilder<SwitchController>(
                    builder: (switchController) {
                      return Container(
                        width: 180,
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: SettingsCustomDropdownMenu(
                          items: const ['WHO', 'DGE'],
                          dropdownValue: classificationDropDownValue,
                          onChanged: (newValue) {
                            setState(() {
                              switchController.toggleClassificationUnit(newValue!);
                              classificationDropDownValue = newValue;
                            });
                          },
                          labelText: 'Classification',

                        ),
                      );
                    }
                  ),
                  classificationDropDownValue == 'WHO'
                      ? Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Adults only',style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ) ,),
        
              Switch(
                  value: switchController.switchValue.value,
                  onChanged: switchController.toggleSwitch,
                ),
        
                    ],
                  )
                      : const Text('( Age independent )',style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                  ) ,),
                  switchController.switchValue.value && classificationDropDownValue == 'WHO'
                      ? const Text('( Age and Gender independent )',
                    style:TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300
                    ) ,)
                      : const SizedBox(),
                   UnitMenu(),

                   const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'More',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  MoreMenu(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Padding MoreMenu() {
    return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [

                      Text(
                        'Remove Ads',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Help & Feedback',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Share this app',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Rate this app',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'More apps',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 180),
                      Center(
                        child: Text(
                          'Developed By',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'SHAKIB ABSAR',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.teal
                          ),
                        ),
                      ),
                    ],
                  ),
                );
  }

  Padding UnitMenu() {
    return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Units',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 60,
                            child: SettingsCustomDropdownMenu(
                              items: const ['ft', 'cm'],
                              dropdownValue: heightUnit,
                              onChanged: (newValue) {
                                setState(() {
                                  heightUnit = newValue!;
                                });
                              },
                              labelText: 'Height',
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 60,
                            child: SettingsCustomDropdownMenu(
                              items: const ['kg', 'lb', 'st'],
                              dropdownValue: weightUnit,
                              onChanged: (newValue) {
                                setState(() {
                                  weightUnit = newValue!;
                                });
                              },
                              labelText: 'Weight',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
  }
}
