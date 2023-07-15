import 'package:flutter/material.dart';

class EmailTextForm extends StatelessWidget {
  const EmailTextForm(
      {Key? key, required this.globalKey, this.hint = 'example@gmail.com'})
      : super(key: key);

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
        hintStyle: const TextStyle(fontSize: 12.0, color: Colors.blue),
        fillColor: Colors.blue[100],
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Colors.blue[100]!,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
