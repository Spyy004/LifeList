import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/models/template.dart';

class ExploreService extends ChangeNotifier {
  List<BucketTemplate> templates = [];
  int getData = 0;
  Future<List<BucketTemplate?>> setTemplates() async {
    if (getData == 0) {
      templates = await fetchTemplates();
      getData = 1;
      notifyListeners();
    }
    return templates;
  }

  editCloneCountInTemplate(BucketTemplate? template) {
    templates.forEach((element) {
      if (element.title == template!.title) {
        element.cloneCount = (element.cloneCount! + 1);
      }
    });
    notifyListeners();
  }
}
