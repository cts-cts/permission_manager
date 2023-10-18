import 'package:get/get.dart';
import 'package:permission_manager/src/pages/permission_manager_page.dart';

class ConfigController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await 2.delay();
    Get.to(() => PermissionManagerPage());
  }
}
