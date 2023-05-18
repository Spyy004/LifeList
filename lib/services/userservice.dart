import 'package:flutter/material.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/controllers/global_controller.dart';

import '../models/index.dart';

class UserService extends ChangeNotifier {
  User user = User();
  bool doNotShowSyncPopup = true;
  void setUser(User currUser) {
    user = currUser;
    notifyListeners();
  }

  Future<void> getUser() async {
    user = await dbService.getUserFromDB();
    if (user.id! >= 0) {
      String docId = user.firstName! + user.lastName! + user.age.toString();
      doNotShowSyncPopup = await checkIfUserExists(docId);
      notifyListeners();
    }
  }

  void syncAccount() {
    doNotShowSyncPopup = !doNotShowSyncPopup;
  }
}
