
class Utils {
  static void printWarning(String message) {
    print("\x1B[33m$message\x1B[33m");
  }

  static void printSuccess(String message) {
    print("\x1B[32m$message\x1B[32m");
  }

  static void printError(String message) {
    print("\x1B[31m$message\x1B[31m");
  }
}

Future<R?> errorHandler<R>({required Future<R?> Function() tryMethod, required Future<R?> Function(Object exception) onErr}) async {
  try {
    return await tryMethod();
  } catch (exception) {
    return await onErr(exception);
  }
}
