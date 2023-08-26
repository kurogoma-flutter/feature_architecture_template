import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../color.dart';

///
/// 共通チェックボックスWidget
///
class PrimaryCheckBox extends StatefulWidget {
  const PrimaryCheckBox({
    required this.onTap,
    required this.text,
    required this.status,
    Key? key,
  }) : super(key: key);

  /// タップされた時の処理
  final AsyncValueSetter<bool> onTap;

  /// チェックボックス右横に表示する文字列
  final String text;

  /// チェック状態
  final bool status;

  @override
  State<PrimaryCheckBox> createState() => _PrimaryCheckBoxState();
}

class _PrimaryCheckBoxState extends State<PrimaryCheckBox> {
  bool isChecked = false;

  /// アニメーションの不透明度
  double opacityLevel = 0;

  /// チェックボックスの枠
  BorderRadius get _checkboxBorderRadius => BorderRadius.circular(8);

  @override
  void initState() {
    super.initState();
    isChecked = widget.status;
    opacityLevel = isChecked ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(PrimaryCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    isChecked = widget.status;
    opacityLevel = isChecked ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                  opacityLevel = isChecked ? 1.0 : 0.0;
                  widget.onTap(isChecked);
                });
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: _checkboxBorderRadius,
                        border: Border.all(
                          width: 2,
                          color: CustomColor.lightBlur,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: opacityLevel,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: _checkboxBorderRadius,
                          gradient: const LinearGradient(
                            tileMode: TileMode.repeated,
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            colors: [
                              CustomColor.pink,
                              CustomColor.orange,
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: opacityLevel,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 200),
                      child: const Center(
                        child: Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: CustomColor.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
