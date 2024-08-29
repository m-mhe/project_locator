import 'package:get/get.dart';
import 'package:project_locator/locate_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LocateController());
  }
}
