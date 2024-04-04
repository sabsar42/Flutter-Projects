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
  bool isMale = true;
  double bmi = 0.0;
  double fHeightCm = 0.0;
  double lHeightCm = 0.0;
  double heightInCm = 0.0; // Height in centimeters
  double weightInKg = 0.0; // Height in centimeters
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
        child: SizedBox(
          height: 700,
          width: 500,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
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
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextField(
                              onChanged: (value) {
                                double cm = double.tryParse(value) ??
                                    0.0; // Parse user input into a double or default to 0.0 if parsing fails

                                heightInCm = cm;
                                calculateBMI(
                                    height: heightInCm, weight: weightInKg);
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
                          flex: 3,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: TextField(
                                    onChanged: (value) {
                                      // Convert height to cm if heightDropdownValue is 'ft'
                                if (heightDropdownValue == 'ft') {
                                  double feet = double.parse(value);
                                  fHeightCm = (feet * 30.48);
                                } else {
                                  fHeightCm = double.parse(value);
                                }
                                heightInCm = fHeightCm;
                                calculateBMI(height: heightInCm, weight: weightInKg);
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
                          flex: 2,
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
                                calculateBMI(height: heightInCm, weight: weightInKg);
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
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          onChanged: (value) {
                            heightInCm = lHeightCm + fHeightCm;
                            weightInKg = double.parse(value);
                            if (weightDropdownValue == 'kg') {
                              calculateBMI(
                                  height: heightInCm, weight: weightInKg);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Weight',
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
                    Flexible(
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
              SizedBox(height: 40),
              Expanded(
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      startAngle: 180,
                      endAngle: 360,
                      minimum: 0,
                      maximum: 90,
                      radiusFactor: 1.4,
                      showLabels: false,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startWidth: 70,
                          endWidth: 70,
                          startValue: 0,
                          endValue: 30,
                          label: 'Underweight',
                          color: Colors.blue,
                        ),
                        GaugeRange(
                          startWidth: 70,
                          endWidth: 70,
                          startValue: 30.3,
                          endValue: 60,
                          label: 'Normal',
                          color: Colors.green,
                        ),
                        GaugeRange(
                          startWidth: 70,
                          endWidth: 70,
                          startValue: 60.3,
                          endValue: 90,
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
                                style: TextStyle(fontSize: 12),
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
                                bmi.toStringAsFixed(2),
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
              Expanded(
                child: ListView.builder(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontWeight: highlight
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: highlight ? Colors.red : Colors.black,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            rangeEnd == 0
                                ? '>= $rangeStart'
                                : '$rangeStart - $rangeEnd',
                            style: TextStyle(
                              fontWeight: highlight
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: highlight ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
      print(bmi);
    });
  }
}