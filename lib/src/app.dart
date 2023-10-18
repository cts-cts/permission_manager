import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_manager/src/base/base_bindings.dart';
import 'package:permission_manager/src/pages/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BaseBindings(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
