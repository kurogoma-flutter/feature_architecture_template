import 'dart:math';

import 'package:flutter/material.dart';

import 'text/tiny_headline_text.dart';

///
/// アコーディオン
///
class AccordionPanel extends StatefulWidget {
  const AccordionPanel({
    Key? key,
    required this.headlineText,
    required this.child,
    this.defaultExpanded = false,
  }) : super(key: key);

  /// 見出しのテキスト
  final String headlineText;

  /// アコーディオンを展開した時に表示されるテキスト
  final Widget child;

  /// アコーディオン開閉状態デフォルト値 - デフォルト「閉」
  final bool defaultExpanded;

  @override
  State<AccordionPanel> createState() => _AccordionPanelState();
}

class _AccordionPanelState extends State<AccordionPanel>
    with SingleTickerProviderStateMixin {
  /// アコーディオンが展開されているかどうか（true: 開いている状態、false: 閉じている状態）
  late bool isExpanded;

  /// 右の矢印アイコンのAnimationController
  late AnimationController rotationController;

  static const double iconSize = 16.0;

  static const Duration animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    rotationController =
        AnimationController(duration: animationDuration, vsync: this);
    isExpanded = widget.defaultExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapAccordion,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.0,
                color: const Color(0x80E4E4E4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TinyHeadLineText(
                      widget.headlineText,
                      maxLine: 1,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: rotationController,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: rotationController.value *
                            (widget.defaultExpanded ? -pi : pi),
                        child: child,
                      );
                    },
                    child: widget.defaultExpanded
                        ? const Icon(Icons.expand_more)
                        : const Icon(Icons.expand_less),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: animationDuration,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            child: isExpanded
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: widget.child)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  /// アコーディオンタップ時処理 - デフォルト値によりControllerの操作を変更する
  void _onTapAccordion() {
    setState(() {
      isExpanded = !isExpanded;
      if (widget.defaultExpanded) {
        isExpanded
            ? rotationController.reverse()
            : rotationController.forward();
      } else {
        isExpanded
            ? rotationController.forward()
            : rotationController.reverse();
      }
    });
  }
}
