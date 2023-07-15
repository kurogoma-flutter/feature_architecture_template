import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button_options.dart';

///
/// Secondaryボタン
///
class SecondaryButton extends StatefulWidget {
  ///
  /// Secondaryボタン(デフォルト・アイコンあり/なし)
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
  factory SecondaryButton({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    bool isActive = true,
    IconPosition iconPosition = IconPosition.left,
  }) {
    return SecondaryButton._(
      key: key,
      onTap: onTap,
      text: text,
      icon: icon,
      isActive: isActive,
      iconPosition: iconPosition,
    );
  }

  ///
  /// Secondaryミニボタン(デフォルト・アイコンあり/なし)
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
  factory SecondaryButton.mini({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    bool isActive = true,
    IconPosition iconPosition = IconPosition.left,
  }) {
    return SecondaryButton._(
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
  /// Secondaryタイニーボタン(デフォルト・アイコンあり/なし)
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
  factory SecondaryButton.tiny({
    Key? key,
    required AsyncCallback onTap,
    String text = '',
    Widget? icon,
    bool isActive = true,
    IconPosition iconPosition = IconPosition.left,
  }) {
    return SecondaryButton._(
      key: key,
      onTap: onTap,
      buttonSizeType: ButtonSizeType.tiny,
      text: text,
      icon: icon,
      isActive: isActive,
      iconPosition: iconPosition,
    );
  }

  const SecondaryButton._({
    Key? key,
    required this.onTap,
    this.text = '',
    this.buttonSizeType = ButtonSizeType.normal,
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
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _enableTap = true;

  static const backgroundColor = Color(0xFFFFFFFF);

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
          child: widget.icon == null
              ? ElevatedButton(
                  onPressed: tapAction,
                  style: _buttonStyle,
                  child: _buttonText(),
                )
              : ElevatedButton.icon(
                  onPressed: tapAction,
                  style: _buttonStyle,
                  icon: iconHasLeft ? widget.icon! : _buttonText(),
                  label: iconHasLeft ? _buttonText() : widget.icon!,
                ),
        ));
  }

  Text _buttonText() {
    return Text(
      widget.text,
      style: _textStyle,
      maxLines: 1,
    );
  }

  TextStyle get _textStyle => TextStyle(
      color:
          widget.isActive ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
      fontSize: widget.buttonSizeType.fontSize,
      fontWeight: widget.buttonSizeType.fontWeight);

  ButtonStyle get _buttonStyle {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color(0xFFBABABA);
        }
        return backgroundColor;
      }),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
        RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(widget.buttonSizeType.buttonRadius)),
      ),
    );
  }

  /// [_enableTap]の値を変更する
  void _setEnableTap(bool enableTap) => setState(() {
        _enableTap = enableTap;
      });
}
