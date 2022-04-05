import 'dart:async';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:get/get.dart';

class CacheUpdateEvent {
  final Future<DateTime> Function() lastUpdateTimeCallback;
  final Future Function() updateActionCallback;
  CacheUpdateEvent({
    required this.lastUpdateTimeCallback,
    required this.updateActionCallback,
  });
}

class CacheFetchingService extends GetxService {
  CacheFetchingService(this.updateInterval);
  ConnectionService connectionService = Get.find();
  final Duration updateInterval;
  Timer? t;

  List<CacheUpdateEvent> _cacheUpdateEvents = [];

  registerEvent({required CacheUpdateEvent cacheUpdateEvent}) {
    _cacheUpdateEvents.add(cacheUpdateEvent);
  }

  Future<CacheFetchingService> init() async {
    if (t is! Timer) {
      t = Timer.periodic(Duration(minutes: 5), (t) => fetch());
    } else {
      throw Exception('Already init');
    }
    return this;
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

  @override
  void onClose() {
    super.onClose();
    if (t is Timer) {
      t!.cancel();
      t = null;
    }
  }
}
