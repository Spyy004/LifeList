import 'package:isar/isar.dart';
import 'package:lifelist/models/bucket.dart';
import 'package:lifelist/models/task.dart';
import 'package:lifelist/models/user.dart';

class DBService {
  late Isar isar;
  initIsar() async {
    isar = await Isar.open([UserSchema, TaskSchema, BucketSchema]);
  }

  Future<int> addUser(User user) async {
    int userId = -1;
    await isar.writeTxn(() async => {userId = await isar.users.put(user)});
    return userId;
  }

  Future<bool> isUserCreated() async {
    int users = await isar.users.getSize();
    return users > 0;
  }

  Future<List<Bucket?>> getBuckets() async {
    List<Bucket?> buckets = [];
    await isar
        .writeTxn(() async => {buckets = await isar.buckets.where().findAll()});
    return buckets;
  }

  Future<int> addBucket(Bucket bucket) async {
    int bucketId = -1;
    await isar
        .writeTxn(() async => {bucketId = await isar.buckets.put(bucket)});
    return bucketId;
  }

  Future<List<int>> addTasks(List<Task> tasks) async {
    List<int> tasksId = [];
    await isar.writeTxn(() async => {tasksId = await isar.tasks.putAll(tasks)});
    return tasksId;
  }

  Future<List<Task?>> getTasks(List<int> ids) async {
    List<Task?> buckets = [];
    ids = ids.where((element) => element >= 0).toList();
    await isar.writeTxn(() async => {buckets = await isar.tasks.getAll(ids)});
    return buckets;
  }

  Future<void> deleteTasks(List<int> ids) async {
    await isar.writeTxn(() async => {await isar.tasks.deleteAll(ids)});
  }

  Future<void> deleteSingleTask(int? id) async {
    await isar.writeTxn(() async => {await isar.tasks.delete(id!)});
  }

  Future<void> deleteTasksfromDB(int? id, int? bucketId) async {
    final bucket = await isar.buckets.where().idEqualTo(bucketId!).findFirst();

    if (bucket != null) {
      // Remove the task from the list of tasks inside the bucket
      bucket.tasks = bucket.tasks.toList();
      bucket.tasks.remove(id);
      await isar.writeTxn(() async => {await isar.buckets.put(bucket)});
      // Update the bucket in the database to persist the changes
    }
  }

  Future<void> deleteSingleBucket(int? id) async {
    await isar.writeTxn(() async => {await isar.buckets.delete(id!)});
  }

  Future<void> editBucketInDB(Bucket bucket) async {
    int? id = bucket.id;
    var toEditBucket = await isar.buckets.where().idEqualTo(id!).findFirst();

    if (toEditBucket != null) {
      // Remove the task from the list of tasks inside the bucket
      toEditBucket = bucket;
      await isar.writeTxn(() async => {await isar.buckets.put(toEditBucket!)});
      // Update the bucket in the database to persist the changes
    }
  }

  Future<User> getUserFromDB() async {
    List<User> user = [];
    await isar
        .writeTxn(() async => {user = await isar.users.where().findAll()});
    return user[0];
  }

  Future<void> clearGlobalData() async {
    await isar.writeTxn(() async => {await isar.buckets.where().deleteAll()});
    await isar.writeTxn(() async => {await isar.tasks.where().deleteAll()});
  }
}
