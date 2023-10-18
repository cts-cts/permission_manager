import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_manager/src/helpers/klog.dart';
import 'package:permission_manager/src/pages/home_page.dart';

class PermissionManagementController extends GetxController {
  final location = Location();

  final isLocationPermissionEnable = RxBool(false);
  final isLocationServiceEnable = RxBool(false);
  final isBattaryOptimizationEnable = RxBool(false);

  @override
  void onReady() async {
    1.delay();

    manageAllPermission();

    super.onReady();
  }

  void manageAllPermission() async {
    if (await enableLocationPermission()) {
      await enableLocationService();

      await enableBattaryOptimization();

      readyToGo();
    }
  }

  Future<void> enableBattaryOptimization() async {
    if (!(await FlutterForegroundTask.isIgnoringBatteryOptimizations)) {
      (!(await FlutterForegroundTask.requestIgnoreBatteryOptimization()));
      await enableBattaryOptimization();
    } else {
      isBattaryOptimizationEnable.value = true;
    }
  }

  Future<void> enableLocationService() async {
    if (await location.serviceEnabled()) {
      isLocationServiceEnable.value = true;
    } else if (await location.requestService()) {
      isLocationServiceEnable.value = true;
    } else {
      await enableLocationService();
    }
  }

  Future<bool> enableLocationPermission() async {
    bool status = false;
    PermissionStatus permissionGranted;
    try {
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return status;
        }
      }
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        isLocationPermissionEnable.value = true;
        status = true;
      } else {
        status = false;
      }
    } catch (e) {
      klog(e);
    }
    return status;
  }

  void readyToGo() async {
    await 1.delay();
    Get.offAll(() => HomePage());
  }
}
