import 'dart:async';
import 'package:salesforce.startup/domain/entities/auth_data.dart';
import 'package:salesforce.startup/domain/services/connections_service.dart';
import 'package:salesforce.startup/domain/services/sf_sdk_service.dart';
import 'package:salesforce.startup/domain/services/sync.dart';
import 'package:get/get.dart';

class CacheUpdateEvent {
  final String tag;
  final Future<DateTime> Function() lastUpdateTimeCallback;
  final Future Function() updateActionCallback;
  CacheUpdateEvent({
    required this.tag,
    required this.lastUpdateTimeCallback,
    required this.updateActionCallback,
  });
}

class CacheFetchingService extends GetxService {
  CacheFetchingService(this.updateInterval);
  ConnectionService connectionService = Get.find();
  SFSDKService _sfsdkService = Get.find();
  final Duration updateInterval;
  Timer? t;

  List<CacheUpdateEvent> _cacheUpdateEvents = [];

  registerEvent({required CacheUpdateEvent cacheUpdateEvent}) {
    _cacheUpdateEvents.removeWhere((element) => element.tag == cacheUpdateEvent.tag);
    _cacheUpdateEvents.add(cacheUpdateEvent);
  }

  @override
  void onReady() {
    super.onReady();

    // Bind to auth events
    _sfsdkService.authData.then((d) {
      if (d != null) start();
    });

    _sfsdkService.authEventStream.listen((event) async {
      AuthData? d = await _sfsdkService.authData;
      if (d != null) {
        start();
      } else {
        stop();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    stop();
  }

  // Start automatic iterations
  start() async {
    parseConfig();
    if (t is! Timer) {
      t = Timer.periodic(Duration(minutes: 5), (t) => fetch());
    }
  }

  // Stop automatic iterations and remove events
  stop() {
    if (t is Timer) {
      t!.cancel();
      t = null;
    }
    _cacheUpdateEvents.clear();
  }

  fetch() {
    if (!connectionService.hasConnection) {
      print('Skip cache update due no connection');
      return;
    }

    print('Start cache update');

    Future.forEach<CacheUpdateEvent>(_cacheUpdateEvents, (event) async {
      try {
        DateTime lastSync = await event.lastUpdateTimeCallback();
        print(DateTime.now().difference(lastSync));
        if (DateTime.now().difference(lastSync) > updateInterval) {
          await event.updateActionCallback();
        }
      } catch (e) {
        print('sync error ' + e.toString());
      }
    });

    print('Cache update complete');
  }
}
