import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id? id;
  late String name;

  @enumerated
  late Priority priority = Priority.medium;

  late String description = '';
  late DateTime deadline = DateTime.now();
  bool isComplete = false;
  late int bucketId = -1;
}

enum Priority { high, medium, low }
