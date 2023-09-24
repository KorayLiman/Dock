import 'package:flutter/foundation.dart';

enum LogColors { black, red, green, yellow, blue, magenta, cyan, white }

abstract class Logger {
  Logger._();

  static void logMsg({required String msg, LogColors color = LogColors.green}) {
    if (kDebugMode || kProfileMode) {
      switch (color) {
        case LogColors.black:
          debugPrint('\x1B[30m$msg\x1B[0m');
        case LogColors.red:
          debugPrint('\x1B[31m$msg\x1B[0m');
        case LogColors.green:
          debugPrint('\x1B[32m$msg\x1B[0m');
        case LogColors.yellow:
          debugPrint('\x1B[33m$msg\x1B[0m');
        case LogColors.blue:
          debugPrint('\x1B[34m$msg\x1B[0m');
        case LogColors.magenta:
          debugPrint('\x1B[35m$msg\x1B[0m');
        case LogColors.cyan:
          debugPrint('\x1B[36m$msg\x1B[0m');
        case LogColors.white:
          debugPrint('\x1B[37m$msg\x1B[0m');
      }
    }
  }
}
