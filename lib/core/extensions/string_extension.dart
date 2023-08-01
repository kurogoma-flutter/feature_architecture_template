import 'dart:math';

extension StringExtension on String? {
  // 日付変換
  DateTime toDate() => DateTime.parse(this!);
  // 数値変換
  int toInt() => int.parse(this!);
  // 数値変換（double）
  double toDouble() => double.parse(this!);
  // URLかどうか判定
  bool get isUrl => RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(this!);
  // IDかどうか判定
  bool get isId => RegExp(r'[a-zA-Z0-9\-%_/=&?.]+').hasMatch(this!);
  // メールアドレスかどうか判定
  bool get isEmail =>
      RegExp('[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}').hasMatch(this!);

  /// 大文字小文字含む英数字8桁以上
  bool get isPassword =>
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9.?/-]{8,}$')
          .hasMatch(this!);
  // 電話番号かどうか判定
  bool get isPhoneNumber =>
      RegExp(r'^[0-9]{2,4}-[0-9]{2,4}-[0-9]{3,4}$').hasMatch(this!);
  // 郵便番号かどうか判定
  bool get isPostalCode => RegExp(r'^[0-9]{3}-[0-9]{4}$').hasMatch(this!);
  // 文字列が空かどうか判定
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  //数字が0であるか判定する
  bool get isZeroValue {
    if (isNullOrEmpty) {
      return false;
    }
    final value = double.tryParse(this!);
    return value != null && value == 0.0;
  }

  //Map型からキーを指定して文字列を取得する
  String getValueFromMap({
    required Map<String, dynamic> map,
    required String key,
    String defaultValue = '',
  }) {
    if (map.containsKey(key) && map[key] is String) {
      return map[key];
    }
    return defaultValue;
  }

  /// 全角＆半角空白除去
  String? replaceAllSpace(String? text) {
    return text?.replaceAll(RegExp(spaceRegExp), '');
  }

  /// ゼロ補完
  /// （例）columnが3
  /// 1 -> 001
  /// 10 -> 010
  /// 100 -> 100
  String zeroPadding(List<String> target, {int column = 3}) {
    var version = '';
    target.asMap().forEach((int index, String value) {
      version += value.padLeft(column, '0');
    });
    return version;
  }

  /// 長さ[length]の数字のランダム文字列を返却する
  String randomNumberString({required int length}) {
    final rand = Random();
    final codeUnits = List.generate(
      length,
      (index) {
        return rand.nextInt(10);
      },
    );
    return codeUnits.join();
  }

  /// 指定したbyte数値のB～YBの範囲で変換する。decimalsは表示する小数点単位を指定する。
  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) {
      return '0B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    final byteString = (bytes / pow(1024, i)).toStringAsFixed(decimals);
    final formattedByte = decimals > 0 && byteString.endsWith('0' * decimals)
        ? byteString.split('.').first
        : byteString;
    return '$formattedByte${suffixes[i]}';
  }

  String convertToDisplayTime(int second) {
    if (second < secondInOneMinute) {
      return '$second秒';
    } else if (second < secondInOneHour) {
      final minute = second ~/ secondInOneMinute;
      return '$minute分';
    } else {
      final hour = second ~/ secondInOneHour;
      final minute = (second % secondInOneHour) ~/ secondInOneMinute;
      return '$hour時間$minute分';
    }
  }

  // 0, 1で管理されるフラグをboolに変換する
  // 0 -> false
  // 1 -> true
  bool asBool(String? string) {
    return string == '1';
  }
}

const spaceRegExp = r'\s';
const secondInOneMinute = 60;
const secondInOneHour = 3600;
