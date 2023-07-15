import 'package:flutter/material.dart';

import 'text/middle_headline_text.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    Key? key,
    this.title = '',
    this.leading,
    this.trailing,
    this.firstIcon,
    this.secondIcon,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? firstIcon;
  final Widget? secondIcon;

  double get spaceSize => 4.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: MiddleHeadlineText(
              title,
              maxLine: 1,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: (firstIcon != null) ? spaceSize : 0.0,
              ),
              firstIcon ?? const SizedBox.shrink(),
              SizedBox(
                width: (secondIcon != null) ? spaceSize : 0.0,
              ),
              secondIcon ?? const SizedBox.shrink(),
            ],
          )
        ],
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF000000),
      automaticallyImplyLeading: false,
      leading: leading,
      actions: [
        trailing ?? const SizedBox.shrink(),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
