import 'package:isar/isar.dart';

part 'todo_collection.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;

  late String title;

  late String description;

  late bool isCompleted;

  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;
}
