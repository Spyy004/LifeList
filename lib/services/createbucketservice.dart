import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/models/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/global_controller.dart';

class CreateBucketService extends ChangeNotifier {
  bool isEditing = false;
  List<Task> activeBucketTasks = [];
  bool loader = false;
  bool syncCalendar = false;
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
    syncCalendar = false;
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
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).bucketCreationFailedtryagainlater);
      return;
    }
    Fluttertoast.showToast(
        msg: AppLocalizations.of(context).bucketCreatedsuccessfully);

    if(syncCalendar){
      await syncWithCalendar();
    }
    navigationService.navigateReset(context, HOME);
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

  void changeCalendarSyncStatus(){
    syncCalendar = !syncCalendar;
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
    await editBucketinDB(activeSingleBucket);
    loader = false;
    notifyListeners();
  }

  Future<void> syncWithCalendar() async {
    final Event event = Event(
      title: activeSingleBucket.name,
      description: activeSingleBucket.description,
      location: 'Event location',
      startDate: activeSingleBucket.deadline,
      endDate: activeSingleBucket.deadline.add(Duration(hours: 1)),
    );
    await Add2Calendar.addEvent2Cal(event);
  }
}
