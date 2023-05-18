import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifelist/models/template.dart';

class FirebaseService {
  Future<List<BucketTemplate>> getTemplates() async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('template');

    QuerySnapshot querySnapshot = await collectionReference.get();

    List<BucketTemplate> buckets = [];
    for (var element in querySnapshot.docs) {
      buckets
          .add(BucketTemplate.fromJson(element.data() as Map<String, dynamic>));
    }

    return buckets;
  }

  Future<void> editCloneCountInDB(name) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('template');

    QuerySnapshot<Object?> template =
        await collectionReference.where('title', isEqualTo: name).get();
    late BucketTemplate bucket;
    String id = '';
    template.docs.forEach((ele) => {
          id = ele.id,
          bucket = BucketTemplate.fromJson(ele.data() as Map<String, dynamic>)
        });
    bucket.cloneCount = (bucket.cloneCount! + 1);
    await collectionReference.doc(id).update({'cloneCount': bucket.cloneCount});
  }

  Future<bool> checkIfUserExists(String docId) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('user');

    DocumentSnapshot user = await collectionReference.doc(docId).get();
    return user.exists;
  }
}
