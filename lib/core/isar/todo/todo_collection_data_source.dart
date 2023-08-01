import 'package:isar/isar.dart';

import '../isar_instance.dart';
import 'todo_collection.dart';

class TodoCollectionDataSource {
  final isar = IsarInstance().isar;
  // 一覧取得
  Future<List<Todo>> fetchTodoList() async {
    return isar.todos.where().findAll();
  }

  // 単体データ取得
  Future<Todo?> fetchTodoById(int id) async {
    return isar.todos.where().idEqualTo(id).findFirst();
  }

  // データ追加 / 更新
  Future<void> setTodoData({
    required Todo todoModel,
  }) async {
    // データ追加
    await isar.todos.put(todoModel);
  }

  // データ削除
  Future<void> deleteTodoData({
    required int id,
  }) async {
    // データ削除
    await isar.todos.delete(id);
  }
}
