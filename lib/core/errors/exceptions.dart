/// Exception Abstraction for Data Layer in MASARI
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, {this.statusCode});
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'Network connection failed']);
}

class SecurityException implements Exception {
  final String message;
  const SecurityException(this.message);
}
