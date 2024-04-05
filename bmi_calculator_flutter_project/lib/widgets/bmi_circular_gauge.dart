import 'package:flutter/cupertino.dart';
import 'package:bmi_calculator_flutter_project/utils/dropdown_utils.dart';
import 'package:bmi_calculator_flutter_project/widgets/custom_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class BmiCircularGauge extends StatelessWidget {
  const BmiCircularGauge({
    super.key,
    required this.bmi,
  });

  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}