import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: CustomLogPrinter(),
  output: CustomLogOutput(),
);

/// シンプルな出力
class CustomLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final message = event.message;

    String msg;
    if (message is Function()) {
      msg = message().toString();
    } else if (message is String) {
      msg = message;
    } else {
      msg = message.toString();
    }
    return [
      // ignore: no_adjacent_strings_in_list
      '[${event.level.name.toUpperCase()}] '
          '${DateFormat('HH:mm:ss.SSS').format(DateTime.now())}: '
          '$msg'
    ];
  }
}

class CustomLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    if (event.level.index >= Level.error.index) {
      throw AssertionError('StackTraceを参照してください。');
    }
  }
}

/// ログ出力共通クラス
class Log {
  Log._();
  static void d(dynamic message) => logger.d(message);
  static void i(dynamic message) => logger.i(message);
  static void w(dynamic message) => logger.w(message);
  static void e(dynamic message) => logger.e(message);
  static void v(dynamic message) => logger.v(message);
}
