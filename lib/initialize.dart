import 'dart:async';

import 'core/isar/isar_instance.dart';

class Initialize {
  Future<void> init() async {
    // アプリ実行前の初期化処理
    await IsarInstance().init();
  }
}
