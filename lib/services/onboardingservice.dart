import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/constants/consts.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/index.dart';

class OnboardingService extends ChangeNotifier {
  bool loader = false;
  int userId = -1;
  void registerUser(String firstName, String lastName, int age) {}
  bool checkName(String name, BuildContext context) {
    bool status = name.length >= 3;
    if (!status) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).nametoosmall);
    }
    return status;
  }

  bool checkAge(int age, BuildContext context) {
    bool status = age > 0 && age <= 100;
    if (!status) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).ageshouldbelessthanhundredandgreaterthanzero,
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
      Fluttertoast.showToast(msg: AppLocalizations.of(context).userregisteredsuccesfully);
      if (context.mounted) {
        navigationService.navigateNext(context, HOME);
      }
      loader = false;
      notifyListeners();
      return;
    }
    loader = false;
    notifyListeners();
    Fluttertoast.showToast(msg:  AppLocalizations.of(context).userregisterationfailedTryagainlater);
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
