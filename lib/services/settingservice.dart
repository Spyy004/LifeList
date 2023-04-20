import 'package:flutter/material.dart';
import 'package:lifelist/controllers/global_controller.dart';

class SettingsService extends ChangeNotifier {
  bool loader = false;
  clearData() {
    loader = !loader;
    clearGlobalData();
    notifyListeners();
    loader = !loader;
  }
}
