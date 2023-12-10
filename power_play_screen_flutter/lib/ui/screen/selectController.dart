import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SelectController extends GetxController {

  List<bool> selectedItems = List.generate(20, (index) => false);
  @override
  void update([List<Object>? ids, bool condition = true]) {

    super.update(ids, condition);
  }
}