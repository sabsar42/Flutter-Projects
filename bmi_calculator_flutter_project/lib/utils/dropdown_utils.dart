
import 'package:flutter/cupertino.dart';

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

CustomDropdownMenu SettingsDropDownMenu({
  required String dropdownValue,
  required ValueChanged<String?> onChanged,
}) {
  return CustomDropdownMenu(
    items: ['Settings'],
    dropdownValue: dropdownValue,
    onChanged: onChanged,
  );
}