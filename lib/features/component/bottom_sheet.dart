import 'dart:ui';

import 'package:flutter/material.dart';

import '../../router/app_router.dart';

///
/// 共通ボトムシートWidget
/// 画面全体にモーダルを表示する
///
class PrimaryBottomSheet extends StatelessWidget {
  /// [titleText] :タイトルのテキスト
  /// [body] :ボディ部分のwidget
  const PrimaryBottomSheet({
    Key? key,
    this.titleText = '',
    required this.body,
  }) : super(key: key);

  /// タイトルのテキスト
  final String titleText;

  /// ボディのWidget
  final Widget body;

  /// ヘッダのクローズボタンの大きさ
  static const imageWidth = 24.0;

  /// ヘッダのクローズボタンの横のスペース
  static const headerSideSpace = 16.0;

  /// 装飾コンテナの色
  static const Color backgroundColorBegin = Color(0xFFE528CF);
  static const Color backgroundColorEnd = Color(0xFFFE8B29);

  /// 装飾コンテナのサイズ
  static const borderHeight = 4.0;
  static const borderWidth = 295.0;

  /// タイトルテキストのテキストスタイル
  static const titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  /// モーダルマスクカラー
  static const Color backGroundMaskColor = Color(0x20FFFFFF);

  /// すりガラスフィルター
  ImageFilter get _filter => ImageFilter.blur(sigmaX: 30, sigmaY: 30);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: BackdropFilter(
          filter: _filter,
          child: Container(
            color: backGroundMaskColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: imageWidth + headerSideSpace,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            titleText,
                            style: titleStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => AppRouter().closeBottomSheet(context),
                        child: const Icon(Icons.close),
                      ),
                      const SizedBox(
                        width: headerSideSpace,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: borderHeight,
                  width: borderWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(borderHeight / 2),
                    ),
                    gradient: LinearGradient(
                      tileMode: TileMode.repeated,
                      colors: [backgroundColorBegin, backgroundColorEnd],
                    ),
                  ),
                ),
                body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
