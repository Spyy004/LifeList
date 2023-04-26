import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';

import '../models/index.dart';

class TaskService extends ChangeNotifier {
  List<Task?> tasks = [];
  List<Task> temporaryTasks = [];
  double completionPercentage = 0;
  int fetchStatus = 0;
  Future<List<int>> addTaskstoDB(List<Task> tasks) async {
    List<int> taskIds = [];
    taskIds = await addTasksinDB(tasks);
    return taskIds;
  }

  Future<void> transferTemporaryTasks() async {
    tasks = tasks.toList();
    tasks.addAll(temporaryTasks);
    temporaryTasks = [];
    fetchStatus = 1;
    notifyListeners();
  }

  Future<void> fetchActiveBucketTaskDetails(
      List<int> taskIds, Bucket bucket) async {
    if (fetchStatus == 1) {
      return;
    }
    tasks = await fetchTasksFromDB(taskIds);
    int doneTasks =
        tasks.where((element) => element!.isComplete == true).length;
    completionPercentage = (doneTasks / tasks.length) * 100;

    //await bucketService.setActiveSingleBucket(bucket);
  }

  Future<void> deleteSingleTask(int? taskId, String taskName) async {
    if (taskId == null) {
      tasks.removeWhere(
          (element) => element?.id == null && element!.name == taskName);
      notifyListeners();
      return;
    }
    await deleteSingeTaskFromDB(taskId);
    int doneTasks =
        tasks.where((element) => element!.isComplete == true).length;
    completionPercentage = (doneTasks / tasks.length) * 100;

    notifyListeners();
  }

  void deleteSingleTemporaryTask(int? taskId) async {
    temporaryTasks.removeWhere((element) => element.id == taskId);
    notifyListeners();
  }

  void addSingleTemporaryTask(String taskTitle) {
    Task task = Task();
    task.name = taskTitle;
    temporaryTasks.add(task);
    notifyListeners();
  }

  Future<void> updateSingleTask(Task task) async {
    if (task.id == null) {
       tasks[
            tasks.indexWhere((element) => task.id == element!.id && element.name == task.name)]!
        .isComplete = !tasks[
       tasks.indexWhere((element) => task.id == element!.id && element.name == task.name)]!
        .isComplete;
    } else {
      Iterable<Task?> foundTask =
          tasks.where((element) => task.id == element?.id);
      foundTask.first?.isComplete = !foundTask.first!.isComplete;
      await updateTaskInDB(task);
    }
    int doneTasks =
        tasks.where((element) => element!.isComplete == true).length;
    completionPercentage = (doneTasks / tasks.length) * 100;
    notifyListeners();
  }

  toggleFetchStatus() {
    fetchStatus = 0;
  }
}
