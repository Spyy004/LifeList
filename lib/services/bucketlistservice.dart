import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/models/bucket.dart';

class BucketListService extends ChangeNotifier {
  List<Bucket?> buckets = [];
  List<Bucket?> filteredBuckets = [];
  int currentAction = 0;

  Future<void> getAllBuckets() async {
    if (currentAction == 0) {
      buckets = await getBucketsFromDB();
      buckets = buckets.whereType<Bucket>().toList();
      filteredBuckets = buckets;
      filteredBuckets.sort((a, b) => a!.compareTo(b!));
      currentAction = 1;
      notifyListeners();
    }
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
}
