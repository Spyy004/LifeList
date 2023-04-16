import 'package:flutter/material.dart';

class NavigationService {
  navigateNext(BuildContext context, String screenName) {
    Navigator.of(context).pushNamed(screenName);
  }

  navigateReset(BuildContext context, String screenName) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false);
  }

  navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
