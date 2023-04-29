import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/models/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/global_controller.dart';

class BucketService extends ChangeNotifier {
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
    activeSingleBucket = bucket;
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
      Fluttertoast.showToast(
          // ignore: use_build_context_synchronously
          msg: AppLocalizations.of(context).bucketCreationFailedtryagainlater);
      return;
    }
    Fluttertoast.showToast(
        msg: AppLocalizations.of(context).bucketCreatedsuccessfully);

    navigationService.navigateReset(context, 'Home');
  }

  changeCurrentBucketStatus() {
    activeSingleBucket.isCompleted = !activeSingleBucket.isCompleted;
    if (activeSingleBucket.bucketScope == BucketScope.daily &&
        activeSingleBucket.isCompleted) {
      activeSingleBucket.streak++;
    } else if (activeSingleBucket.bucketScope == BucketScope.daily &&
        !activeSingleBucket.isCompleted) {
      if (activeSingleBucket.streak > 0) {
        activeSingleBucket.streak--;
      }
    }
    notifyListeners();
  }

  changeCurrentCategory(BucketCategory category) {
    activeSingleBucket.bucketCategory = category;
    notifyListeners();
  }

  void addTaskInActiveBucket(String msg) {
    Task task = Task()..name = msg;
    activeBucketTasks.add(task);
    notifyListeners();
  }

  void deleteTaskFromActiveBucket(int index, int? taskId, String taskName) {
    if (taskId == null) {
      activeBucketTasks.removeWhere(
          (element) => element.id == null && element.name == taskName);
      return;
    }
    if (activeBucketTasks.isEmpty) return;
    activeBucketTasks.removeAt(index);
    notifyListeners();
  }

  void editTaskInActiveBucket(int? taskId, String taskName) {
    if (activeBucketTasks.isEmpty) return;
    activeBucketTasks[activeBucketTasks.indexWhere(
            (element) => taskId == element.id && element.name == taskName)]
        .isComplete = !activeBucketTasks[activeBucketTasks.indexWhere(
            (element) => taskId == element.id && element.name == taskName)]
        .isComplete;
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

  void changeStreak() {
    if (activeSingleBucket.bucketScope == BucketScope.daily) {
      activeSingleBucket.streak++;
    }
  }

  BucketCategory? getBucketCategoryName(String text) {
    return stringToBucketCategory[text];
  }

  Future<void> validateInputs(BuildContext context) async {
    if (activeSingleBucket.name.length < 3) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).titlemustbeatleastthreecharacters);
      return;
    }
    if (activeBucketTasks.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).abucketshouldhaveatleastonetask);
      return;
    }
    await addBucketinDB(context);
  }

  Future<void> deleteTasks(Bucket bucket, int? taskId, int? bucketId) async {
    bucket.tasks = activeSingleBucket.tasks.toList();
    bucket.tasks.remove(taskId);
    await deleteTasksFromBucketDB(taskId, bucketId);
  }

  Future<void> editBucket(
      String name, String desc, BuildContext context) async {
    loader = true;
    notifyListeners();
    if (name.length < 3 && name.isNotEmpty) {
      Fluttertoast.showToast(msg: AppLocalizations.of(context).nametoosmall);
      return;
    }
    if (desc.length < 3 && desc.isNotEmpty) {
      Fluttertoast.showToast(msg: AppLocalizations.of(context).desctoosmall);
      return;
    }
    if (name.isNotEmpty) {
      activeSingleBucket.name = name;
    }
    if (desc.isNotEmpty) {
      activeSingleBucket.description = desc;
    }
    List<int> newTasksId = [];
    if (activeBucketTasks.isNotEmpty) {
      newTasksId = await sendTasksToTaskService(activeBucketTasks);
    }
    activeSingleBucket.tasks = activeSingleBucket.tasks.toList();
    activeSingleBucket.tasks.addAll(newTasksId);
    await editBucketinDB(activeSingleBucket);
    activeBucketTasks = [];
    loader = false;
    notifyListeners();
  }
}
