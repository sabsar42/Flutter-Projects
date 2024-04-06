import 'package:bmi_calculator_flutter_project/screen/settings_screen.dart';
import 'package:bmi_calculator_flutter_project/controller/switch_controller.dart';
import 'package:bmi_calculator_flutter_project/utils/dropdown_utils.dart';
import 'package:bmi_calculator_flutter_project/widgets/bmi_circular_gauge.dart';
import 'package:bmi_calculator_flutter_project/widgets/normal_weight_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/bmi_data_info.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightFtController = TextEditingController();
  TextEditingController heightInchController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController weightStController = TextEditingController();
  TextEditingController weightLbController = TextEditingController();
  TextEditingController weightLbPoundsController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();

  String heightDropdownValue = 'ft';
  String weightDropdownValue = 'kg';
  String settingsValue = 'Settings';
  String bmiCategory = '...';
  bool isMale = true;
  double bmi = 0.0;
  double fHeightCm = 0.0;
  double lHeightCm = 0.0;
  double heightInCm = 0.0;
  double weightInKg = 0.0;
  double weightInStones = 0.0;
  double weightInPounds = 0.0;
  double firstNormalWeight = 0.0;
  double lastNormalWeight = 0.0;


  void resetState() {
    setState(() {
      heightDropdownValue = 'ft';
      weightDropdownValue = 'kg';
      bmiCategory = '...';
      isMale = true;
      bmi = 0.0;
      fHeightCm = 0.0;
      lHeightCm = 0.0;
      heightInCm = 0.0;
      weightInKg = 0.0;
      weightInStones = 0.0;
      weightInPounds = 0.0;
      firstNormalWeight = 0.0;
      lastNormalWeight = 0.0;

      ageController.clear();
      heightFtController.clear();
      heightInchController.clear();
      heightCmController.clear();
      weightKgController.clear();
      weightStController.clear();
      weightLbController.clear();
      weightLbPoundsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              resetState();
            },
            icon: Icon(Icons.refresh_sharp),
          ),
          PopupMenuButton<String>(
            offset: Offset(0, 40),
            onSelected: (String value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen(heightFromUser: heightDropdownValue, weightFromUser: weightDropdownValue,)),
                );
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'settings',
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5), // Adjust the padding here
                  child: Text('Settings'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AgeHeightRow(),
            GenderWeightRow(),
            SizedBox(
              height: 130,
            ),
            BmiCircularGauge(bmi: bmi),
            CategoryAndDifferences(),
            Divider(
              height: 5,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            ),
            BmiDataInfoChart(),
            Divider(
              height: 5,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            ),
            NormalWeightInfo(
                firstNormalWeight: firstNormalWeight,
                lastNormalWeight: lastNormalWeight)
          ],
        ),
      ),
    );
  }

  Container BmiDataInfoChart() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 45),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bmiData.length,
        itemBuilder: (context, index) {
          final item = bmiData[index];
          final category = item['category']!;
          final rangeStart = item['range'][0];
          final rangeEnd = item['range'][1];
          bool highlight = false;

          if (bmi != 0.0 &&
              (bmi >= rangeStart && (bmi < rangeEnd || rangeEnd == 0))) {
            highlight = true;
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    highlight
                        ? Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: getBMIColor(bmi),
                          )
                        : Text(''),
                    Text(
                      category,
                      style: TextStyle(
                        fontWeight:
                            highlight ? FontWeight.bold : FontWeight.normal,
                        color: highlight ? getBMIColor(bmi) : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Text(
                  rangeStart == 0
                      ? '≤ $rangeEnd'
                      : rangeEnd == 0
                          ? '≥ $rangeStart'
                          : '$rangeStart - $rangeEnd',
                  style: TextStyle(
                    fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                    color: highlight ? getBMIColor(bmi) : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column CategoryAndDifferences() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
              Text(
                'Difference',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$bmiCategory',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: getBMIColor(bmi)),
              ),
              Text(
                weightInKg == 0.0
                    ? '...'
                    : weightInKg < firstNormalWeight
                        ? '-${(firstNormalWeight - weightInKg).toStringAsFixed(1)} kg'
                        : weightInKg > lastNormalWeight
                            ? '+${(weightInKg - lastNormalWeight).toStringAsFixed(1)} kg'
                            : '✓', // Check icon
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: getBMIColor(bmi)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding GenderWeightRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 30),
      child: Row(
        children: [
          Flexible(
            child: IconButton(
              onPressed: () {
                setState(() {
                  isMale = false;
                });
              },
              icon: Icon(
                Icons.woman_outlined,
                size: 40,
                color: isMale == false ? Colors.teal : null,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey,
          ),
          Flexible(

            child: IconButton(
              onPressed: () {
                setState(() {
                  isMale = true;
                });
              },
              icon: Icon(
                Icons.man_outlined,
                size: 40,
                color: isMale == true ? Colors.teal : null,
              ),
            ),
          ),
          weightDropdownValue == 'st'
              ? Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: weightStController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              weightInStones = double.parse(value);
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'st',
                              hintStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w200),
                              labelText: 'St',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30.0),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: weightLbController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              weightInPounds = double.parse(value);
                              weightInKg = (weightInStones * 6.35029) +
                                  (weightInPounds * 0.453592);
                              calculateBMI(
                                  height: heightInCm, weight: weightInKg);
                              normalWeight(height: heightInCm);
                            },
                            decoration: InputDecoration(
                              hintText: 'lb',
                              hintStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w200),
                              labelText: 'lb',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: weightDropdownValue == 'kg'
                          ? weightKgController
                          : weightLbPoundsController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        heightInCm = lHeightCm + fHeightCm;
                        double weightCustom = double.parse(value);
                        if (weightDropdownValue == 'kg') {
                          weightInKg = weightCustom;
                          calculateBMI(height: heightInCm, weight: weightInKg);
                          normalWeight(height: heightInCm);
                        } else if (weightDropdownValue == 'lb') {
                          weightInKg = weightCustom * 0.453592;
                          calculateBMI(height: heightInCm, weight: weightInKg);
                          normalWeight(height: heightInCm);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        hintText: weightDropdownValue == 'kg' ? 'kg' : 'lb',
                        hintStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            flex: 2,
            child: WeightMetricsDropDownMenu(
              dropdownValue: weightDropdownValue,
              onChanged: (newValue) {
                setState(() {
                  weightDropdownValue = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  GetBuilder<GetxController> AgeHeightRow() {
    return GetBuilder<SwitchController>(
      builder: (switchController) {

        return Row(
          children: [
            switchController.switchValue.value?const SizedBox():
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  ),
                ),
              ),
            ),
            heightDropdownValue == 'cm'
                ? Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        controller: heightCmController,
                        onChanged: (value) {
                          double cm = double.tryParse(value) ?? 0.0;

                          heightInCm = cm;
                          calculateBMI(height: heightInCm, weight: weightInKg);
                          normalWeight(height: heightInCm);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "cm",
                          labelStyle: TextStyle(
                            fontSize: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: 4.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextField(
                              controller: heightFtController,
                              onChanged: (value) {
                                if (heightDropdownValue == 'ft') {
                                  double feet = double.parse(value);
                                  fHeightCm = (feet * 30.48);
                                } else {
                                  fHeightCm = double.parse(value);
                                }
                                heightInCm = fHeightCm;
                                calculateBMI(
                                    height: heightInCm, weight: weightInKg);
                                normalWeight(height: heightInCm);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "ft",
                                labelText: "'",
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 4.0),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextField(
                              controller: heightInchController,
                              onChanged: (value) {
                                if (heightDropdownValue == 'ft') {
                                  double inches = double.parse(value);
                                  lHeightCm = (inches * 2.54);
                                } else {
                                  lHeightCm = double.parse(value);
                                }
                                heightInCm = fHeightCm + lHeightCm;
                                calculateBMI(
                                    height: heightInCm, weight: weightInKg);
                                normalWeight(height: heightInCm);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "in",
                                labelText: '"',
                                labelStyle: TextStyle(
                                  fontSize: 25,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 4.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Flexible(
              flex: 2,
              child: HeightMetricsDropDownMenu(
                dropdownValue: heightDropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    heightDropdownValue = newValue!;
                  });
                },
              ),
            ),
          ],
        );
      }
    );
  }

  void calculateBMI({required double height, required double weight}) {
    setState(() {
      bmi = (weight / (height * height)) * 10000;

      for (var item in bmiData) {
        final rangeStart = item['range'][0];
        final rangeEnd = item['range'][1];
        final category = item['category']!;

        if (bmi >= rangeStart && (bmi < rangeEnd || rangeEnd == 0)) {
          setState(() {
            bmiCategory = category;
          });
          break;
        }
      }
    });
  }

  Color getBMIColor(double bmi) {
    if (bmi == 0.0) {
      return Colors.black87;
    } else if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi > 24.9) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  void normalWeight({required double height}) {
    setState(() {
      firstNormalWeight = (18.5 * (height * height)) / 10000;
      lastNormalWeight = (24.9 * (height * height)) / 10000;
    });
  }
}
