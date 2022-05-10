class CacheException implements Exception {
  final String message;

  const CacheException([this.message = ""]);

  String toString() => "CacheException: $message";
}

class ServerException implements Exception {
  final String message;

  const ServerException([this.message = ""]);

  String toString() => "ServerException: $message";
}

class InternalException implements Exception {
  final String message;

  const InternalException([this.message = ""]);

  String toString() => "InternalException: $message";
}
