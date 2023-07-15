import 'package:flutter/widgets.dart';

///
/// テキスト大
/// フォントサイズ：16
/// フォントウェイト：w3
/// [textColor] : 表示テキストの色(Default: 白0xFFFFFFFF)
/// [maxLine] : 最大行数
/// [textOverflow] : 描画がOverflowした場合の動作(Default: ３点リーダー)
///
class LargeText extends StatelessWidget {
  const LargeText(
    this.text, {
    Key? key,
    Color? textColor,
    this.maxLine,
    this.textOverflow = TextOverflow.ellipsis,
    this.textAlign,
  })  : _textColor = textColor ?? const Color(0xFFFFFFFF),
        super(key: key);

  /// 表示テキスト
  final String text;

  /// テキストカラー
  final Color _textColor;

  /// 最大行数
  final int? maxLine;

  /// 描画がOverflowした場合の動作
  final TextOverflow? textOverflow;

  /// テキストアライン
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        color: _textColor,
        overflow: textOverflow,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
