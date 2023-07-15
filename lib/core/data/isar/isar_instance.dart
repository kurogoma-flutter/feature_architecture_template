import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'todo/todo_collection.dart';

class IsarInstance {
  factory IsarInstance() {
    return _singleton;
  }
  IsarInstance._internal();
  static final IsarInstance _singleton = IsarInstance._internal();

  Isar? _isar;

  Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    _isar = await Isar.open(
      [
        TodoSchema,
      ],
      directory: kIsWeb ? '' : dir.path,
      inspector: true,
    );
  }

  Isar get isar => _isar!;

  IsarCollection<Todo> get todos => _isar!.collection<Todo>();
}
