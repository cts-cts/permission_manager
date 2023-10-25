import 'package:get/get.dart';
import 'package:permission_manager/src/controllers/config_controller.dart';
import 'package:permission_manager/src/controllers/permission_management_controller.dart';
import 'package:permission_manager/src/services/location_service.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfigController());
    Get.lazyPut(() => PermissionManagementController());
    Get.lazyPut(() => LocationService());
  }
}
