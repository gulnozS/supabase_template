/// Generic exception used by data sources for controlled failures.
class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException(message: $message)';
}
