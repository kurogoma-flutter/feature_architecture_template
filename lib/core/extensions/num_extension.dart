import 'dart:math';

import 'package:intl/intl.dart';

extension NumExtension on num {
  /// 数字を3桁区切りにする
  String get toThousandsSeparator => thousandsSeparator.format(this);

  /// 数字をパーセント付きの文字列にする
  String toPercentString(int number) {
    return '$number%';
  }

  /// 数字を通貨表記の文字列にする
  String toCurrencyString() {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ja_JP', symbol: '¥');
    return currencyFormatter.format(this);
  }

  double roundWithDigit(int digit) {
    final digitValue = pow(10, digit);
    return (this * digitValue).roundToDouble() / digitValue;
  }

  double floorWithDigit(int digit) {
    final digitValue = pow(10, digit);
    return (this * digitValue).floorToDouble() / digitValue;
  }
}

/// 数字を3桁区切りにする
final thousandsSeparator = NumberFormat('#,###');
