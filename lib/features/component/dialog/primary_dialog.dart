import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/router/app_router.dart';
import '../color.dart';

///
/// ダイアログ
/// [considerStatusBar] : ステータスバー表示領域を考慮するか(Default: 有効true)
/// [considerNavigationBar] : ナビゲーションバー表示領域を考慮するか(Default: 有効true)
///
class PrimaryDialog extends StatelessWidget {
  const PrimaryDialog({
    required this.child,
    Key? key,
    this.considerStatusBar = true,
    this.considerNavigationBar = true,
    this.onTapCloseButton,
    this.showCloseButton = true,
  }) : super(key: key);

  final Widget child;

  /// SafeAreaのステータスバー表示領域を考慮する
  final bool considerStatusBar;

  /// SafeAreaのナビゲーションバー表示領域を考慮する
  final bool considerNavigationBar;

  /// closeボタンタップ時処理は必須の想定では無いためnullable指定にしている。指定がない場合はモーダルを閉じる
  final VoidCallback? onTapCloseButton;

  /// closeボタンを表示するか否か
  final bool showCloseButton;

  static const borderRadius = 16.0;
  static const borderWidth = 1.0;

  static const backgroundColor = CustomColor.black;
  static const dialogColor = CustomColor.darkBlur;
  static const borderColor = CustomColor.lightGrey;

  static const closeButtonSize = 40.0;

  static ImageFilter get filter => ImageFilter.blur(sigmaX: 30, sigmaY: 30);

  @override
  Widget build(BuildContext context) {
    // 閉じるボタンのTop Padding値をステータスバー考慮するかを参照し値を変更する
    final paddingTopValue =
        considerStatusBar ? 16 : 16 + MediaQuery.of(context).padding.top;

    return SafeArea(
      top: considerStatusBar,
      bottom: considerNavigationBar,
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: BackdropFilter(
                        filter: filter,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: borderWidth,
                              color: borderColor,
                            ),
                            color: dialogColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: child,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            if (showCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, paddingTopValue.toDouble(), 16, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(closeButtonSize / 2.0),
                    child: BackdropFilter(
                      filter: filter,
                      child: SizedBox(
                        width: closeButtonSize,
                        height: closeButtonSize,
                        child: InkWell(
                          onTap: onTapCloseButton ??
                              () => AppRouter().pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
