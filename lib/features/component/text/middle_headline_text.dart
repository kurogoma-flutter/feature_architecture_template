import 'package:flutter/material.dart';

class MiddleHeadlineText extends StatelessWidget {
  const MiddleHeadlineText(
    this.text, {
    Key? key,
    Color? textColor,
    this.maxLine,
    this.textOverflow = TextOverflow.ellipsis,
  })  : _textColor = textColor ?? const Color(0xFFFFFFFF),
        super(key: key);

  /// 表示テキスト
  final String text;

  /// テキストカラー
  final Color? _textColor;

  /// 最大行数
  final int? maxLine;

  /// 描画がOverflowした場合の動作
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: maxLine,
      style: TextStyle(
        color: _textColor,
        overflow: textOverflow,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
