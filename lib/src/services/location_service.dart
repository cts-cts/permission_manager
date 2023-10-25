import 'dart:async';
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
        isOnceEvent: true,
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    klog('Location Service Channel Initialized');
  }

  void startLocationService() {
    FlutterForegroundTask.startService(
      notificationTitle: 'Live Location Tracker',
      notificationText: 'Listening your live location',
      callback: locationServiceCallback,
    );
  }
}

@pragma('vm:entry-point')
void locationServiceCallback() {
  FlutterForegroundTask.setTaskHandler(LocationServiceHandler());
}

class LocationServiceHandler extends TaskHandler {
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    klog('onStart');
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await FlutterForegroundTask.updateService(
      notificationText: '${position.latitude}, ${position.longitude}',
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      if (position != null) {
        await FlutterForegroundTask.updateService(
          notificationText: '${position.latitude}, ${position.longitude}',
        );
      }
    });
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {
    klog('onDestroy');
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) {
    klog('onRepeatEvent');
  }
}
