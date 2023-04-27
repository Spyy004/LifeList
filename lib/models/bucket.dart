import 'package:isar/isar.dart';

part 'bucket.g.dart';

@collection
class Bucket {
  Id? id;
  String name = '';
  String description = '';
  @enumerated
  BucketCategory bucketCategory = BucketCategory.fitness;
  bool isCompleted = false;
  List<int> tasks = List.empty(growable: true);
  DateTime deadline = DateTime.now();

  int compareTo(Bucket other) {
    return deadline.compareTo(other.deadline);
  }
}

enum BucketCategory {
  travel,
  finance,
  adventure,
  career,
  fitness,
  personalitydevelopment,
  creativity,
  relationships,
}
