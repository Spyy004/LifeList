import 'package:flutter/material.dart';

class LandingService extends ChangeNotifier {
  int index = 0;

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
