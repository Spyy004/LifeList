import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/constants/consts.dart';
import 'package:lifelist/controllers/global_controller.dart';

import '../models/index.dart';

class OnboardingService extends ChangeNotifier {
  bool loader = false;
  int userId = -1;
  void registerUser(String firstName, String lastName, int age) {}
  bool checkName(String name) {
    bool status = name.length >= 3;
    if (!status) {
      Fluttertoast.showToast(
          msg: 'Name and LastName should be atleast 3 chars');
    }
    return status;
  }

  bool checkAge(int age) {
    bool status = age > 0 && age <= 100;
    if (!status) {
      Fluttertoast.showToast(
        msg: 'Age should be less than 100 & greater than 0 ',
      );
    }
    return status;
  }

  void submitDetails(
      String name, String lastName, String age, BuildContext context) async {
    loader = true;
    notifyListeners();
    User currUser = User();
    currUser.createUser(name, lastName, int.parse(age));
    userId = await addUserToDB(currUser);
    if (userId >= 0) {
      currUser.id = userId;
      setCurrentUser(currUser);
      Fluttertoast.showToast(msg: 'User registered succesfully');
      if (context.mounted) {
        navigationService.navigateNext(context, HOME);
      }
      loader = false;
      notifyListeners();
      return;
    }
    loader = false;
    notifyListeners();
    Fluttertoast.showToast(msg: 'User registeration failed, Try again later');
  }

  Map<String, dynamic> createConfig(String name, String lastName, String age) {
    Map<String, dynamic> config = {
      'name': name,
      'lastName': lastName,
      'age': int.parse(age)
    };
    return config;
  }
}
