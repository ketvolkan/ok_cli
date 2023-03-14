import 'package:talker_logger/talker_logger.dart';

class Utils {
  static void printWarning(String message) {
    logger.warning("[WARNING] $message");
  }

  static void printSuccess(String message) {
    logger.good("[SUCCESS] $message");
  }

  static void printError(String message) {
    logger.error("[ERROR] $message");
  }

  static void printInfo(String message) {
    logger.info("[INFO] $message");
  }
}

TalkerLogger get logger => TalkerLogger();

Future<R?> errorHandler<R>({required Future<R?> Function() tryMethod, required Future<R?> Function(Object exception) onErr}) async {
  try {
    return await tryMethod();
  } catch (exception) {
    return await onErr(exception);
  }
}
