import 'package:flutter/material.dart';
import 'package:lifelist/constants/index.dart';

import '../models/index.dart';

class UserService extends ChangeNotifier {
  User user = User();

  void setUser(User currUser) {
    user = currUser;
    notifyListeners();
  }

  Future<void> getUser() async {
    user = await dbService.getUserFromDB();
  }
}
