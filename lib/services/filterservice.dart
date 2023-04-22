import 'package:flutter/material.dart';
import 'package:lifelist/models/bucket.dart';

class FilterService extends ChangeNotifier{
  bool currentStatus = false;
  List<BucketCategory> currentCategories = List.empty(growable: true);

  void toggleStatus(bool value){
    currentStatus = value;
    notifyListeners();
  }
  void toggleCategory(BucketCategory category){
    if(currentCategories.contains(category)){
      currentCategories.remove(category);
    }else{
      currentCategories.add(category);
    }
    notifyListeners();
  }

  void resetFilters(){
    currentStatus = false;
    currentCategories = List.empty(growable: true);
    notifyListeners();
  }
}