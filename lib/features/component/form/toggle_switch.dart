import 'package:flutter/material.dart';

import '../color.dart';

///
/// 共通トグルスイッチWidget_デフォルトサイズ
///
class ToggleSwitchDefault extends StatefulWidget {
  const ToggleSwitchDefault({
    required this.status,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// チェック状態
  /// true => onの状態、スイッチが右側
  /// false => offの状態、スイッチが左側
  final bool status;

  /// スイッチをタップされたときの処理
  final ValueChanged<bool> onChanged;

  @override
  State<ToggleSwitchDefault> createState() => _ToggleSwitchDefaultState();
}

class _ToggleSwitchDefaultState extends State<ToggleSwitchDefault>
    with TickerProviderStateMixin {
  bool isSwitched = false;

  /// スイッチの高さ
  static const double height = 32;

  /// スイッチの幅
  static const double width = 56;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSwitched = !isSwitched;
          widget.onChanged(isSwitched);
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: isSwitched
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(height / 2),
                gradient: const LinearGradient(
                  tileMode: TileMode.repeated,
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    CustomColor.orange,
                    CustomColor.pink,
                  ],
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(height / 2),
                color: CustomColor.lightGrey,
              ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: AnimatedAlign(
            alignment:
                isSwitched ? Alignment.centerRight : Alignment.centerLeft,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
