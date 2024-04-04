import 'package:bmi_calculator_flutter_project/widgets/custom_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiApp extends StatefulWidget {
  const BmiApp({Key? key}) : super(key: key);

  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {
  String heightDropdownValue = 'ft';
  String weightDropdownValue = 'kg';
  String bmiCategory = '...';
  bool isMale = true;
  double bmi = 0.0;
  double fHeightCm = 0.0;
  double lHeightCm = 0.0;
  double heightInCm = 0.0; // Height in centimeters
  double weightInKg = 0.0; // Height in centimeters
  double weightInStones = 0.0; // Height in centimeters
  double weightInPounds = 0.0; // Height in centimeters
  double firstNormalWeight = 0.0;
  double lastNormalWeight = 0.0;
  final List<Map<String, dynamic>> bmiData = [
    {
      'range': [0, 15],
      'category': 'Very Severely Underweight'
    },
    {
      'range': [16.0, 16.9],
      'category': 'Severely Underweight'
    },
    {
      'range': [17.0, 18.4],
      'category': 'Underweight'
    },
    {
      'range': [18.5, 24.9],
      'category': 'Normal'
    },
    {
      'range': [25.0, 29.9],
      'category': 'Overweight'
    },
    {
      'range': [30.0, 34.9],
      'category': 'Obesity Class I'
    },
    {
      'range': [35.0, 39.9],
      'category': 'Obesity Class II'
    },
    {
      'range': [40, 0],
      'category': 'Obesity Class III'
    },
  ];

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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 1.0),
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
                            onChanged: (value) {
                              double cm = double.tryParse(value) ?? 0.0;

                              heightInCm = cm;
                              calculateBMI(
                                  height: heightInCm, weight: weightInKg);
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
            ),
            Padding(
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
                        size: 35,
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
                        size: 35,
                        color: isMale == true ? Colors.teal : null,
                      ),
                    ),
                  ),
                  weightDropdownValue=='st'?
                  Expanded(
                    flex: 8,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // Parse the value into stones
                                weightInStones = double.parse(value);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'st',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200
                                ),
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
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // Parse the value into pounds
                                weightInPounds = double.parse(value);

                                // Calculate weight in kilograms
                                weightInKg = (weightInStones * 6.35029) + (weightInPounds * 0.453592);

                                // Calculate BMI
                                calculateBMI(height: heightInCm, weight: weightInKg);

                                // Calculate normal weight
                                normalWeight(height: heightInCm);
                              },
                              decoration: InputDecoration(
                                hintText: 'lb',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200
                                ),
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
                  ):
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          heightInCm = lHeightCm + fHeightCm;
                          double weightCustom = double.parse(value);
                          if (weightDropdownValue == 'kg') {
                            weightInKg = weightCustom;
                            calculateBMI(
                                height: heightInCm, weight: weightInKg);
                            normalWeight(height: heightInCm);
                          } else if (weightDropdownValue == 'lb') {
                            weightInKg = weightCustom * 0.453592;
                            calculateBMI(
                                height: heightInCm, weight: weightInKg);
                            normalWeight(height: heightInCm);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          hintText: weightDropdownValue == 'kg' ? 'kg' : 'lb',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200
                          ),
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
            ),
            SizedBox(
              height: 130,
            ),
            Container(
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
                    // Adjust label offset as needed
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
                        endValue: 40.0,
                        label: 'Overweight',
                        color: Colors.red,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        enableAnimation: true,
                        value: bmi,
                        needleLength: 0.67,
                        needleColor: Colors.white,
                        needleStartWidth: 0.5,
                        needleEndWidth: 55,
                        knobStyle: KnobStyle(
                          knobRadius: 0,
                          borderWidth: 0,
                        ),
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Center(
                          child: Container(
                            child: Text(
                              'BMI',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        angle: 620,
                        positionFactor: 0.2,
                      ),
                      GaugeAnnotation(
                        widget: Center(
                          child: Container(
                            child: Text(
                              bmi.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            Divider(
              height: 5,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            ),
            Container(
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

                  // Highlight range if BMI falls within it
                  bool highlight =
                      bmi >= rangeStart && (bmi < rangeEnd || rangeEnd == 0);

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: TextStyle(
                            fontWeight:
                                highlight ? FontWeight.bold : FontWeight.normal,
                            color: highlight ? getBMIColor(bmi) : Colors.black,
                          ),
                        ),
                        SizedBox(width: 20),
                        Center(
                          child: Text(
                            rangeStart == 0
                                ? '≤ $rangeEnd'
                                : rangeEnd == 0
                                    ? '≥ $rangeStart'
                                    : '$rangeStart - $rangeEnd',
                            style: TextStyle(
                              fontWeight: highlight
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color:
                                  highlight ? getBMIColor(bmi) : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: 5,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Normal Weight',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    firstNormalWeight == 0.0 || lastNormalWeight == 0.0
                        ? '...'
                        : '${firstNormalWeight.toStringAsFixed(1)} - ${lastNormalWeight.toStringAsFixed(1)} kg',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  CustomDropdownMenu HeightMetricsDropDownMenu({
    required String dropdownValue,
    required ValueChanged<String?> onChanged,
  }) {
    return CustomDropdownMenu(
      items: ['ft', 'cm'],
      dropdownValue: dropdownValue,
      onChanged: onChanged,
    );
  }

  CustomDropdownMenu WeightMetricsDropDownMenu({
    required String dropdownValue,
    required ValueChanged<String?> onChanged,
  }) {
    return CustomDropdownMenu(
      items: ['kg', 'lb', 'st'],
      dropdownValue: dropdownValue,
      onChanged: onChanged,
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
          break; // Exit loop once category is found
        }
      }
    });
  }

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) {
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
