import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:permission_manager/src/helpers/klog.dart';

class LocationService extends GetxService {
  @override
  void onInit() {
    initLocationServiceChannel();
    super.onInit();
  }

  @override
  void onReady() {
    startLocationService();
    super.onReady();
  }

  void initLocationServiceChannel() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'location_service_tracker',
        channelName: 'Location Tracker',
        channelDescription: 'Location Service for track your location',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        isOnceEvent: false,
        interval: 60000,
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    klog('Location Service Channel Initialized');
  }

  void startLocationService() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService();
    } else {
      await FlutterForegroundTask.startService(
        notificationTitle: 'Live Location Tracker',
        notificationText: 'Listening your live location',
        callback: locationServiceCallback,
      );
    }
  }
}

@pragma('vm:entry-point')
void locationServiceCallback() {
  FlutterForegroundTask.setTaskHandler(LocationServiceHandler());
}

class LocationServiceHandler extends TaskHandler {
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {}

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {}

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );
  }
}
