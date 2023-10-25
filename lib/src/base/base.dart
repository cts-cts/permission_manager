import 'package:get/get.dart';
import 'package:permission_manager/src/controllers/config_controller.dart';
import 'package:permission_manager/src/controllers/permission_management_controller.dart';
import 'package:permission_manager/src/services/location_service.dart';

class Base {
  Base._();

  static final configController = Get.find<ConfigController>();

  static final permissionManagementController =
      Get.find<PermissionManagementController>();

  static final locationService = Get.find<LocationService>();
}
