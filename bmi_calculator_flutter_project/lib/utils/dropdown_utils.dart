
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drop_down_menu.dart';

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

class SettingsCustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String dropdownValue;
  final ValueChanged<String?> onChanged;
  final String labelText;

  const SettingsCustomDropdownMenu({
    Key? key,
    required this.items,
    required this.dropdownValue,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 10.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 10.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}
