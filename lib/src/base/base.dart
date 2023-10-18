import 'package:get/get.dart';
import 'package:permission_manager/src/controllers/config_controller.dart';
import 'package:permission_manager/src/controllers/permission_management_controller.dart';

class Base {
  Base._();

  static final configController = Get.find<ConfigController>();

  static final permissionManagementController =
      Get.find<PermissionManagementController>();
}
