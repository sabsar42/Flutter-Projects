import 'package:flutter/material.dart';

class NormalWeightInfo extends StatelessWidget {
  const NormalWeightInfo({
    super.key,
    required this.firstNormalWeight,
    required this.lastNormalWeight,
  });

  final double firstNormalWeight;
  final double lastNormalWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
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
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}