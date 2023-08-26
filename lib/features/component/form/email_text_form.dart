import 'package:flutter/material.dart';

import '../color.dart';

class EmailTextForm extends StatelessWidget {
  const EmailTextForm({
    required this.globalKey,
    Key? key,
    this.hint = 'example@gmail.com',
  }) : super(key: key);

  final GlobalKey globalKey;
  final String hint;
  static const emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: globalKey,
      maxLines: 1,
      validator: (value) {
        final regExp = RegExp(emailRegExp);
        if (value != null && regExp.hasMatch(value)) {
          return null;
        }
        return 'バリデーションエラー';
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: CustomColor.blue),
        fillColor: CustomColor.lightBlue,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: CustomColor.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: CustomColor.lightBlue,
            width: 1,
          ),
        ),
      ),
    );
  }
}
