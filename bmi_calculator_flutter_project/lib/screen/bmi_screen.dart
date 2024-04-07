import 'package:bmi_calculator_flutter_project/controller/toggle_controller.dart';
import 'package:bmi_calculator_flutter_project/screen/settings_screen.dart';
import 'package:bmi_calculator_flutter_project/utils/dropdown_utils.dart';
import 'package:bmi_calculator_flutter_project/widgets/normal_weight_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      Get.find<ToggleController>().heightDropdownValue.value = 'ft';
      Get.find<ToggleController>().weightDropdownValue.value = 'kg';
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
        title: const Text(
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
            icon: const Icon(Icons.refresh_sharp),
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 40),
            onSelected: (String value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()),
                );
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'settings',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            ageHeightRow(),
            genderWeightRow(),
            const SizedBox(
              height: 130,
            ),
            bmiCircularGauge(),
            categoryAndDifferences(),
            const Divider(
              height: 5,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            ),
            bmiDataInfoChart(),
            const Divider(
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

  SizedBox bmiCircularGauge() {
    return SizedBox(
      height: 120,
      width: 300,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 180,
            endAngle: 360,
            minimum: 10.0,
            maximum: 40.0,
            radiusFactor: 3,
            showLabels: true,
            labelOffset: 14,
            showLastLabel: true,
            showAxisLine: true,
            showFirstLabel: true,
            showTicks: true,
            tickOffset: 58,
            interval: 5.0,
            ranges: <GaugeRange>[
              GaugeRange(
                startWidth: 70,
                endWidth: 70,
                startValue: 10,
                endValue: 18.4,
                label: 'Underweight',
                color: Colors.blue,
              ),
              GaugeRange(
                startWidth: 70,
                endWidth: 70,
                startValue: 18.5,
                endValue: 24.9,
                label: 'Normal',
                color: Colors.green,
              ),
              GaugeRange(
                startWidth: 70,
                endWidth: 70,
                startValue: 25.0,
                endValue: 49.0,
                label: 'Overweight',
                color: Colors.red,
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                enableAnimation: true,
                value: bmi,
                needleLength: 0.72,
                needleColor: Colors.white,
                needleStartWidth: 0.5,
                needleEndWidth: 60,
                knobStyle: const KnobStyle(
                  knobRadius: 0,
                  borderWidth: 0,
                ),
              ),
            ],
            annotations: <GaugeAnnotation>[
              const GaugeAnnotation(
                widget: Center(
                  child: Text(
                    'BMI',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                angle: 620,
                positionFactor: 0.2,
              ),
              GaugeAnnotation(
                widget: Center(
                  child: Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: getBMIColor(bmi),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container bmiDataInfoChart() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 45),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bmiData.length,
        itemBuilder: (context, index) {
          final item = bmiData[index];
          final category = item['category']!;
          final rangeStart = item['range'][0];
          final rangeEnd = item['range'][1];
          bool highlight = false;

          if (bmi != 0.0 &&
              (bmi >= rangeStart && (bmi <= rangeEnd || rangeEnd == 0))) {
            highlight = true;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
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
                        : const Text(''),
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
                const SizedBox(width: 20),
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

  Column categoryAndDifferences() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: const Row(
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bmiCategory,
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
                            : '✓',
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

  GetBuilder<ToggleController> genderWeightRow() {
    return GetBuilder<ToggleController>(builder: (toggleController) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 30),
        child: Row(
          children: [
            toggleController.switchValue.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    child: Text(
                      'Weight',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ))
                : Flexible(
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
            toggleController.switchValue.value
                ? const SizedBox()
                : const SizedBox(
                    width: 10,
                  ),
            toggleController.switchValue.value
                ? const SizedBox()
                : Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey,
                  ),
            toggleController.switchValue.value
                ? const SizedBox()
                : Flexible(
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
            toggleController.weightDropdownValue.value == 'st'
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
                              decoration: const InputDecoration(
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
                              onChanged: stLbToKg,
                              decoration: const InputDecoration(
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
                        controller:
                            toggleController.weightDropdownValue.value == 'kg'
                                ? weightKgController
                                : weightLbPoundsController,
                        keyboardType: TextInputType.number,
                        onChanged: finalBmiCalculation,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          hintText:
                              toggleController.weightDropdownValue.value == 'kg'
                                  ? 'kg'
                                  : 'lb',
                          hintStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w200),
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 2,
              child: weightMetricsDropDownMenu(
                dropdownValue: toggleController.weightDropdownValue.value,
                onChanged: (newValue) {
                  setState(() {
                    toggleController.toggleWeightUnit(newValue!);
                    toggleController.weightDropdownValue.value = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  GetBuilder<GetxController> ageHeightRow() {
    return GetBuilder<ToggleController>(builder: (toggleController) {
      return Row(
        children: [
          toggleController.switchValue.value ||
                  toggleController.classificationUnit == 'DGE'.obs
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                  child: Text(
                    'Height',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ))
              : Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 1.0),
                      ),
                    ),
                  ),
                ),
          toggleController.heightDropdownValue.value == 'cm'
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
                      decoration: const InputDecoration(
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
                              if (toggleController.heightDropdownValue.value ==
                                  'ft') {
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
                            decoration: const InputDecoration(
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
                            onChanged: feetToCm,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
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
            child: heightMetricsDropDownMenu(
              dropdownValue: toggleController.heightDropdownValue.value,
              onChanged: (newValue) {
                setState(() {
                  toggleController.toggleHeightUnit(newValue!);
                  toggleController.heightDropdownValue.value = newValue;
                });
              },
            ),
          ),
        ],
      );
    });
  }

  void feetToCm(value) {
    if (Get.find<ToggleController>().heightDropdownValue.value == 'ft') {
      double inches = double.parse(value);
      lHeightCm = (inches * 2.54);
    } else {
      lHeightCm = double.parse(value);
    }
    heightInCm = fHeightCm + lHeightCm;
    calculateBMI(height: heightInCm, weight: weightInKg);
    normalWeight(height: heightInCm);
  }

  void calculateBMI({required double height, required double weight}) {
    setState(() {
      bmi = double.parse(((weight / (height * height)) * 10000).toStringAsFixed(1));

      for (var item in bmiData) {
        final rangeStart = item['range'][0];
        final rangeEnd = item['range'][1];
        final category = item['category']!;
        if (bmi >= rangeStart && (bmi <= rangeEnd || rangeEnd == 0)) {
          setState(() {
            bmiCategory = category;
          });
          break;
        }
      }
    });
  }
  void finalBmiCalculation(value) {
    heightInCm = lHeightCm + fHeightCm;
    double weightCustom = double.parse(value);
    if (Get.find<ToggleController>().weightDropdownValue.value == 'kg') {
      weightInKg = weightCustom;
      calculateBMI(height: heightInCm, weight: weightInKg);
      normalWeight(height: heightInCm);
    } else if (Get.find<ToggleController>().weightDropdownValue.value == 'lb') {
      weightInKg = weightCustom * 0.453592;
      calculateBMI(height: heightInCm, weight: weightInKg);
      normalWeight(height: heightInCm);
    }
  }

  void stLbToKg(value) {
    weightInPounds = double.parse(value);
    weightInKg = (weightInStones * 6.35029) + (weightInPounds * 0.453592);
    calculateBMI(height: heightInCm, weight: weightInKg);
    normalWeight(height: heightInCm);
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