import 'package:flutter/material.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/models/template.dart';

import '../models/index.dart';

class ExploreService extends ChangeNotifier {
  List<BucketTemplate> templates = [];
  List<BucketTemplate> filteredTemplates = [];
  int getData = 0;
  Future<List<BucketTemplate?>> setTemplates() async {
    if (getData == 0) {
      templates = await fetchTemplates();
      filteredTemplates = templates;
      getData = 1;
      notifyListeners();
    }
    return filteredTemplates;
  }

  editCloneCountInTemplate(BucketTemplate? template) {
    for (var element in templates) {
      if (element.title == template!.title) {
        element.cloneCount = (element.cloneCount! + 1);
      }
    }
    notifyListeners();
  }

  filterBuckets(List<BucketCategory> categories, bool status) {
    if (categories.isEmpty) {
      filteredTemplates = templates.where((element) {
        if (element.isCompleted == status) {
          return true;
        }
        return false;
      }).toList();
      notifyListeners();
      return;
    }
    filteredTemplates = templates.where((element) {
      if (categories.contains(stringToBucketCategory[element.category]) &&
          element.isCompleted == status) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  resetFilter() {
    filteredTemplates = templates;
    notifyListeners();
  }
}
