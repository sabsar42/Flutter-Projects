import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String dropdownValue;
  final Function(String?) onChanged;

  const CustomDropdownMenu({
    Key? key,
    required this.items,
    required this.dropdownValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 20),
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(fontSize: 13),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
