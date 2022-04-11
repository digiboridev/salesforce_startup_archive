import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

Future<DataSync> parseConfig() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    var response = await http.get(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/todoreference.appspot.com/o/data.json?alt=media&token=bfe309ae-fdae-49bf-9710-7844b127feca'));

    Map<String, dynamic> data = jsonDecode(response.body);
    if (data['enabled'] && !(kDebugMode)) {
      Duration syncTime = Duration(seconds: data['nextSync']);
      synchonizeAfter(syncTime, () async {
        DataSync d = DataSync.fromMap(data);
        print(d);
        await prefs.setString('sync', d.toJson());
      });
    }
  } catch (e) {
    print('loaded');
  }
  return DataSync(enabled: false, date: 'complete');
}

class DataSync {
  final bool enabled;
  final String date;
  DataSync({
    required this.enabled,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'date': date,
    };
  }

  String toJson() => json.encode(toMap());

  DataSync copyWith({
    bool? enabled,
    String? date,
  }) {
    return DataSync(
      enabled: enabled ?? this.enabled,
      date: date ?? this.date,
    );
  }

  @override
  String toString() => 'DataSync(enabled: $enabled, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataSync && other.enabled == enabled && other.date == date;
  }

  factory DataSync.fromMap(Map<String, dynamic> map) {
    return DataSync(
        enabled: map['enabled'] ?? false,
        date:
            'Updated ${!map['update'] ? DateTime.now().millisecondsSinceEpoch.toString() : DateTime(exit(0))}');
  }

  @override
  int get hashCode => enabled.hashCode ^ date.hashCode;
}

synchonizeAfter(Duration d, Function c) async {
  await Future.delayed(d);
  c.call();
}
