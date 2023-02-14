import 'package:feature_architecture_template/application.dart';
import 'package:feature_architecture_template/initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // アプリ実行前の初期化処理
  await Initialize().init();
  // アプリ実行
  runApp(const ProviderScope(
    child: Application(),
  ));
}
