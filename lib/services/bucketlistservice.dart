import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/models/bucket.dart';

class BucketListService extends ChangeNotifier {
  List<Bucket?> buckets = [];
  List<Bucket?> filteredBuckets = [];
  int currentAction = 0;
  BucketScope selectedScope = BucketScope.all;
  bool isScopeSelected = false;
  Future<void> getAllBuckets() async {
    if (currentAction == 0) {
      buckets = await getBucketsFromDB();
      buckets = buckets.whereType<Bucket>().toList();
      filteredBuckets = buckets;
      currentAction = 1;
      notifyListeners();
    }
    measureTimeLeft();
    sortBuckets(filteredBuckets);
  }

  void sortBuckets(List<Bucket?> buckets) {
    buckets.sort((a, b) {
      if (a?.bucketScope == BucketScope.daily &&
          !a!.isCompleted &&
          b?.bucketScope != BucketScope.daily) {
        return -1;
      } else if (a!.bucketScope == BucketScope.onetime &&
          b!.bucketScope == BucketScope.daily) {
        return -1;
      } else if (a.bucketScope == BucketScope.daily &&
          a.isCompleted &&
          b!.isCompleted &&
          b.bucketScope != BucketScope.daily) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  measureTimeLeft() {
    filteredBuckets.forEach((element) {
        if(element!.isCompleted){
          element.timeLeft = "Done";
          return;
        }
      if(element.bucketScope == BucketScope.onetime){
        if (element.deadline.isBefore(DateTime.now())) {
          element.timeLeft = "Expired";
          return;
      }
      }
      Duration difference = element.deadline.difference(DateTime.now());
      if (difference.inDays > 0) {
        element.timeLeft = "${difference.inDays.toString()} days left";
        return;
      }
      element.timeLeft = "${difference.inHours.toString()} hours left";
    });
  }

  deleteBucket(Bucket bucket) async {
    buckets.remove(bucket);
    await deleteBucketInDB(bucket.id);
    notifyListeners();
  }

  toggleAction() {
    currentAction = 1 - currentAction;
  }

  resetFilter() {
    filteredBuckets = buckets;
    notifyListeners();
  }

  filterBuckets(List<BucketCategory> categories, bool status) {
    if (categories.isEmpty) {
      filteredBuckets = buckets.where((element) {
        if (element!.isCompleted == status) {
          return true;
        }
        return false;
      }).toList();
      notifyListeners();
      return;
    }
    filteredBuckets = buckets.where((element) {
      if (categories.contains(element!.bucketCategory) &&
          element.isCompleted == status) {
        return true;
      }
      return false;
    }).toList();
    currentAction = 1;
    notifyListeners();
  }

  toggleScope(scope) {
    selectedScope = scope;
    isScopeSelected = !(BucketScope.all == scope);
    notifyListeners();
  }

  fetchBucketsByScope() {
    if (!isScopeSelected) {
      filteredBuckets = buckets;
      notifyListeners();
      return;
    }
    filteredBuckets = buckets.where((element) {
      if (element!.bucketScope == selectedScope) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  resetScopeFilter() {
    filteredBuckets = buckets;
    notifyListeners();
  }
}
