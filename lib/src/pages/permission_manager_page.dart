import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_manager/src/base/base.dart';

class PermissionManagerPage extends StatefulWidget {
  @override
  State<PermissionManagerPage> createState() => _PermissionManagerPageState();
}

class _PermissionManagerPageState extends State<PermissionManagerPage> {
  @override
  void initState() {
    Base.permissionManagementController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/permission.png',
                    width: 160,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Location Permission',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: Base.permissionManagementController
                            .isLocationPermissionEnable.value,
                        trackColor: Colors.red,
                        onChanged: (v) {
                          Base.permissionManagementController
                              .enableLocationPermission();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Location Service',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: Base.permissionManagementController
                            .isLocationServiceEnable.value,
                        trackColor: Colors.red,
                        onChanged: (v) {
                          Base.permissionManagementController
                              .enableLocationService();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Battary Optimization',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        trackColor: Colors.red,
                        value: Base.permissionManagementController
                            .isBattaryOptimizationEnable.value,
                        onChanged: (v) {
                          Base.permissionManagementController
                              .enableBattaryOptimization();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
