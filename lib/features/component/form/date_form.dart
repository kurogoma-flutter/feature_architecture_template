import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../color.dart';
import '../text/tiny_headline_text.dart';

///
/// iOSライクな日付ピッカーを表示する日付フォーム
/// [selectingDate] : 選択中の日付
/// [minimumDate] : 選択可能な最小値
/// [maximumDate] : 選択可能な最大値
/// [onConfirm] : ツールバー決定ボタンタップ時のイベント
///
class DateForm extends StatelessWidget {
  const DateForm({
    required this.selectingDate,
    required this.minimumDate,
    required this.maximumDate,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  /// 選択中の日付
  final DateTime selectingDate;

  /// 選択可能な最小値
  final DateTime minimumDate;

  /// 選択可能な最大値
  final DateTime maximumDate;

  /// ツールバー決定ボタンタップ時のイベント
  final Function(DateTime date) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: CustomColor.lightBlur,
        ),
      ),
      height: 44,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TinyHeadLineText(
                  DateFormat('yyyy / MM / dd').format(selectingDate).toString(),
                  maxLine: 1,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today_rounded),
            ],
          ),
        ),
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => _DatePicker(
              initialDateTime: selectingDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onClose: () {
                Navigator.pop(context);
              },
              onConfirm: (date) {
                onConfirm(date);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
    required this.onClose,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  /// 選択中の日付
  final DateTime initialDateTime;

  /// 選択可能な最小値
  final DateTime minimumDate;

  /// 選択可能な最大値
  final DateTime maximumDate;

  /// ツールバーxボタンタップ時のイベント
  final Function() onClose;

  /// ツールバー決定ボタンタップ時のイベント
  final Function(DateTime date) onConfirm;

  @override
  Widget build(BuildContext context) {
    var selectingDateTime = initialDateTime;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          height: 44,
          color: CustomColor.white,
          child: Row(
            children: [
              Material(
                color: CustomColor.white,
                child: CloseButton(
                  color: CustomColor.blueGrey,
                  onPressed: onClose,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  onConfirm(selectingDateTime);
                },
                child: const Text(
                  '決定',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6),
          color: CustomColor.white,
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              selectingDateTime = newDate;
            },
          ),
        )
      ],
    );
  }
}
