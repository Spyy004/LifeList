import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/models/index.dart';

import '../controllers/global_controller.dart';

class CreateBucketService extends ChangeNotifier {
  bool isEditing = false;
  List<Task> activeBucketTasks = [];
  bool loader = false;
  // DateTime activeBucketDeadlineDate = DateTime.now();
  Bucket activeSingleBucket = Bucket()
    ..name = ''
    ..description = ''
    ..bucketCategory = BucketCategory.career
    ..id = null
    ..deadline = DateTime.now()
    ..isCompleted = false
    ..tasks = [];

  clearData() {
    activeSingleBucket = Bucket();
    activeBucketTasks = [];
    isEditing = false;
  }

  Future<void> setActiveSingleBucket(Bucket bucket) async {
    if (activeSingleBucket.id == null) {
      activeSingleBucket = bucket;
    }
  }

  void changeEditStatus() {
    isEditing = !isEditing;
    notifyListeners();
  }

  addBucketinDB(BuildContext context) async {
    List<int> taskIds = await sendTasksToTaskService(activeBucketTasks);
    Bucket bucket = Bucket()
      ..bucketCategory = activeSingleBucket.bucketCategory
      ..name = activeSingleBucket.name
      ..description = activeSingleBucket.description
      ..isCompleted = activeSingleBucket.isCompleted
      ..deadline = activeSingleBucket.deadline
      ..tasks = taskIds;
    int bucketId = await addBucketToDB(bucket);
    if (bucketId == -1) {
      Fluttertoast.showToast(msg: 'Bucket Creation Failed, try again later');
      return;
    }
    Fluttertoast.showToast(msg: 'Bucket Created successfully');

    navigationService.navigateReset(context, 'Home');
  }

  changeCurrentBucketStatus() {
    activeSingleBucket.isCompleted = !activeSingleBucket.isCompleted;
    notifyListeners();
  }

  void addTaskInActiveBucket(String msg) {
    Task task = Task()..name = msg;
    activeBucketTasks.add(task);
    notifyListeners();
  }

  void deleteTaskFromActiveBucket(int index) {
    activeBucketTasks.removeAt(index);
    notifyListeners();
  }

  Future<void> setActiveBucketDeadlineDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      activeSingleBucket.deadline = pickedDate;
    }
    notifyListeners();
  }

  void setActiveBucketName(String text) {
    activeSingleBucket.name = text;
  }

  void setActiveDescriptionName(String text) {
    activeSingleBucket.description = text;
  }

  void setActiveBucketType(String text) {
    activeSingleBucket.bucketCategory = getBucketCategoryName(text)!;
    notifyListeners();
  }

  BucketCategory? getBucketCategoryName(String text) {
    return maps[text];
  }

  Future<void> validateInputs(BuildContext context) async {
    if (activeSingleBucket.name.length < 3) {
      Fluttertoast.showToast(msg: 'Title must be atleast 3 characters');
      return;
    }
    if (activeBucketTasks.isEmpty) {
      Fluttertoast.showToast(msg: "A Bucket should have atleast 1 task");
      return;
    }
    await addBucketinDB(context);
  }

  Future<void> deleteTasks(Bucket bucket, int? taskId, int? bucketId) async {
    bucket.tasks = activeSingleBucket.tasks.toList();
    bucket.tasks.remove(taskId);
    await deleteTasksFromBucketDB(taskId, bucketId);
  }

  Future<void> editBucket(String name, String desc) async {
    loader = true;
    notifyListeners();
    if (name.length < 3 && name.isNotEmpty) {
      Fluttertoast.showToast(msg: 'Name too small');
      return;
    }
    if (desc.length < 3 && desc.isNotEmpty) {
      Fluttertoast.showToast(msg: 'Desc too small');
      return;
    }
    if (name.isNotEmpty) {
      activeSingleBucket.name = name;
    }
    if (desc.isNotEmpty) {
      activeSingleBucket.description = desc;
    }
    await editBucketinDB(activeSingleBucket);
    loader = false;
    notifyListeners();
  }
}
