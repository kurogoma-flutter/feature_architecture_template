import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.isShowAppBar = true,
    this.appBarTitle = '',
    this.onPressedFab,
    this.fabIcon,
  });

  final bool isShowAppBar;
  final String appBarTitle;
  final Widget child;
  final Function()? onPressedFab;
  final IconData? fabIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 55, 55, 55),
      appBar: isShowAppBar
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                appBarTitle,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 55, 55, 55),
            )
          : null,
      body: child,
      floatingActionButton: fabIcon != null
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 91, 180, 252),
              onPressed: onPressedFab,
              child: Icon(
                fabIcon,
                color: const Color.fromARGB(255, 231, 244, 255),
              ),
            )
          : const SizedBox(),
    );
  }
}
