class Logger {
  static void info(String message, [Map<String, dynamic>? data]) {
    print('INFO: $message ${data ?? ''}');
  }

  static void error(String message, [dynamic error]) {
    print('ERROR: $message ${error ?? ''}');
  }

  static void warning(String message, [Map<String, dynamic>? data]) {
    print('WARNING: $message ${data ?? ''}');
  }
}