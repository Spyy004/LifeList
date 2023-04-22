import 'package:lifelist/constants/index.dart';

import '../models/index.dart';

addUserToDB(User user) async {
  int userId = await dbService.addUser(user);
  return userId;
}

setCurrentUser(User user) {
  userService.setUser(user);
}

Future<List<Bucket?>> getBucketsFromDB() async {
  List<Bucket?> buckets = await dbService.getBuckets();
  return buckets;
}

addBucketToDB(Bucket bucket) async {
  int bucketId = await dbService.addBucket(bucket);
  return bucketId;
}

Future<List<int>> addTasksinDB(List<Task> tasks) async {
  List<int> taskIds = await dbService.addTasks(tasks);
  return taskIds;
}

Future<List<int>> sendTasksToTaskService(List<Task> tasks) async {
  List<int> task = await taskService.addTaskstoDB(tasks);
  return task;
}

Future<List<Task?>> fetchTasksFromDB(List<int> taskIds) async {
  List<Task?> buckets = await dbService.getTasks(taskIds);
  return buckets;
}

Future<void> deleteTasksFromDB(List<int> taskId) async {
  await dbService.deleteTasks(taskId);
}

Future<void> deleteSingeTaskFromDB(int? taskId) async {
  await dbService.deleteSingleTask(taskId);
}

Future<void> deleteTasksFromBucketDB(int? taskId, int? bucketId) async {
  await dbService.deleteTasksfromDB(taskId, bucketId);
}

Future<void> deleteBucketInDB(int? id) async {
  await dbService.deleteSingleBucket(id);
}

Future<void> editBucketinDB(Bucket bucket) async {
  await dbService.editBucketInDB(bucket);
}

Future<void> clearGlobalData() async {
  await dbService.clearGlobalData();
}

Future<void> updateTaskInDB(Task task) async {
  await dbService.updateTaskInDB(task);
}
