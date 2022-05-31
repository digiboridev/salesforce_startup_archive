import 'dart:convert';

class SyncData {
  final DateTime syncDateTime;
  final String locale;
  SyncData({
    required this.syncDateTime,
    required this.locale,
  });

  Map<String, dynamic> toMap() {
    return {
      'syncDateTime': syncDateTime.millisecondsSinceEpoch,
      'locale': locale,
    };
  }

  factory SyncData.fromMap(Map<String, dynamic> map) {
    return SyncData(
      syncDateTime: DateTime.fromMillisecondsSinceEpoch(map['syncDateTime']),
      locale: map['locale'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SyncData.fromJson(String source) =>
      SyncData.fromMap(json.decode(source));

  @override
  String toString() => 'SyncData(syncDateTime: $syncDateTime, locale: $locale)';
}
