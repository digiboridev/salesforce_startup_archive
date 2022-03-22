class CacheException implements Exception {
  final String message;

  const CacheException([this.message = ""]);

  String toString() => "FormatException: $message";
}

class ServerException implements Exception {
  final String message;

  const ServerException([this.message = ""]);

  String toString() => "FormatException: $message";
}
