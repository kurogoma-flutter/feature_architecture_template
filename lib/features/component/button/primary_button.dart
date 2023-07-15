import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button_options.dart';

///
/// Primaryボタン
///
class PrimaryButton extends StatefulWidget {
  ///
  /// Primaryボタン(デフォルト・アイコンあり/なし)
  ///
  /// ボタンの高さ : 48
  ///
  /// [onTap] : タップ時動作
  ///
  /// [icon] : ボタン中に表示するアイコン(Default: なし)
  ///
  /// [iconPosition] : icon指定時に表示する位置(Default: 左)
  ///
  /// [isActive] : ボタン活性化フラグ(Default: true)
  ///
  factory PrimaryButton({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    bool isActive = true,
    IconPosition iconPosition = IconPosition.left,
  }) {
    return PrimaryButton._(
      key: key,
      onTap: onTap,
      text: text,
      icon: icon,
      isActive: isActive,
      iconPosition: iconPosition,
    );
  }

  ///
  /// ミニボタン(デフォルト・アイコンあり/なし)
  ///
  /// ボタンの高さ : 36
  ///
  /// [onTap] : タップ時動作
  ///
  /// [icon] : ボタン中に表示するアイコン(Default: なし)
  ///
  /// [iconPosition] : icon指定時に表示する位置(Default: 左)
  ///
  /// [isActive] : ボタン活性化フラグ(Default: true)
  ///
  factory PrimaryButton.mini({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    bool isActive = true,
    IconPosition iconPosition = IconPosition.left,
  }) {
    return PrimaryButton._(
      key: key,
      onTap: onTap,
      buttonSizeType: ButtonSizeType.mini,
      text: text,
      icon: icon,
      isActive: isActive,
      iconPosition: iconPosition,
    );
  }

  ///
  /// タイニーボタン(デフォルト・アイコンあり/なし)
  ///
  /// ボタンの高さ : 32
  ///
  /// [onTap] : タップ時動作
  ///
  /// [icon] : ボタン中に表示するアイコン(Default: なし)
  ///
  /// [iconPosition] : icon指定時に表示する位置(Default: 左)
  ///
  /// [isActive] : ボタン活性化フラグ(Default: true)
  ///
  factory PrimaryButton.tiny({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    IconPosition iconPosition = IconPosition.left,
    bool isActive = true,
  }) {
    return PrimaryButton._(
      key: key,
      onTap: onTap,
      buttonSizeType: ButtonSizeType.tiny,
      text: text,
      icon: icon,
      isActive: isActive,
      iconPosition: iconPosition,
    );
  }

  const PrimaryButton._({
    Key? key,
    required this.onTap,
    this.buttonSizeType = ButtonSizeType.normal,
    this.text = '',
    this.icon,
    this.isActive = true,
    required this.iconPosition,
  }) : super(key: key);

  /// タップされた時の処理
  final AsyncCallback onTap;

  /// ボタンに表示する文字列
  final String text;

  /// ボタンの大きさ
  final ButtonSizeType buttonSizeType;

  /// ボタン内アイコン
  final Widget? icon;

  /// ボタン内アイコン表示位置
  final IconPosition iconPosition;

  /// ボタン活性化フラグ
  final bool isActive;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _enableTap = true;

  static const Color backgroundColorBegin = Color(0xFFFF903C);

  static const Color backgroundColorEnd = Color(0xFFFF0576);

  @override
  Widget build(BuildContext context) {
    final iconHasLeft = widget.iconPosition == IconPosition.left;

    final tapAction = widget.isActive
        ? () async {
            _setEnableTap(false);
            await widget.onTap();
            _setEnableTap(true);
          }
        : null;

    return ConstrainedBox(
      constraints:
          BoxConstraints.expand(height: widget.buttonSizeType.buttonHeight),
      child: AbsorbPointer(
        absorbing: !_enableTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _buttonBorderRadius,
            gradient: const LinearGradient(
              tileMode: TileMode.repeated,
              colors: [backgroundColorBegin, backgroundColorEnd],
            ),
          ),
          child: widget.icon == null
              ? ElevatedButton(
                  style: _buttonStyle(),
                  onPressed: tapAction,
                  child: _buttonText())
              : ElevatedButton.icon(
                  style: _buttonStyle(),
                  onPressed: tapAction,
                  icon: iconHasLeft ? widget.icon! : _buttonText(),
                  label: iconHasLeft ? _buttonText() : widget.icon!,
                ),
        ),
      ),
    );
  }

  Text _buttonText() {
    return Text(
      widget.text,
      style: _textStyle,
      maxLines: 1,
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color(0xFFBABABA);
        }
        return Colors.transparent;
      }),
      elevation: MaterialStateProperty.all(0),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: _buttonBorderRadius),
      ),
    );
  }

  BorderRadius get _buttonBorderRadius => BorderRadius.circular(22.0);

  TextStyle get _textStyle => TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: widget.buttonSizeType.fontSize,
      fontWeight: widget.buttonSizeType.fontWeight);

  /// [_enableTap]の値を変更する
  void _setEnableTap(bool enableTap) => setState(() {
        _enableTap = enableTap;
      });
}
