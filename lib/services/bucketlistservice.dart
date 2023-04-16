import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/models/bucket.dart';

class BucketListService extends ChangeNotifier {
  List<Bucket?> buckets = [];

  Future<void> getAllBuckets() async {
    buckets = await getBucketsFromDB();
    buckets = buckets.whereType<Bucket>().toList();
  }

  deleteBucket(Bucket bucket) async {
    buckets.remove(bucket);
    await deleteBucketInDB(bucket.id);
    notifyListeners();
  }
}
