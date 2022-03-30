import 'dart:async';
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
  final Duration updateInterval;
  late Timer t;

  List<CacheUpdateEvent> _cacheUpdateEvents = [];

  registerEvent({required CacheUpdateEvent cacheUpdateEvent}) {
    _cacheUpdateEvents.add(cacheUpdateEvent);
  }

  init() {
    if (t is! Timer) {
      t = Timer.periodic(Duration(minutes: 1), (t) => fetch());
    } else {
      throw Exception('Already init');
    }
  }

  fetch() {
    Future.forEach<CacheUpdateEvent>(_cacheUpdateEvents, (event) async {
      DateTime lastSync = await event.lastUpdateTimeCallback();
      if (lastSync.difference(DateTime.now()) > updateInterval) {
        await event.updateActionCallback();
      }
    });
  }
}
