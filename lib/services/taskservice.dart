import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';

import '../models/index.dart';

class TaskService extends ChangeNotifier {
  List<Task?> tasks = [];

  Future<List<int>> addTaskstoDB(List<Task> tasks) async {
    List<int> taskIds = [];
    taskIds = await addTasksinDB(tasks);
    return taskIds;
  }

  Future<void> fetchActiveBucketTaskDetails(
      List<int> taskIds, Bucket bucket) async {
    tasks = await fetchTasksFromDB(taskIds);
    //await bucketService.setActiveSingleBucket(bucket);
  }

  Future<void> deleteSingleTask(int? taskId) async {
    await deleteSingeTaskFromDB(taskId);
    notifyListeners();
  }

  Future<void> updateSingleTask(Task task) async {
    Iterable<Task?> foundTask =
    tasks.where((element) => task.id == element?.id);
    foundTask.first?.isComplete = !foundTask.first!.isComplete;
    await updateTaskInDB(task);
    notifyListeners();
  }
}
