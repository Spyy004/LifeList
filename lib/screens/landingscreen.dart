import 'package:flutter/material.dart';
import 'package:lifelist/screens/explorescreen.dart';
import 'package:lifelist/services/landingservice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'homescreen.dart';
import 'profilescreen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingService>(
      builder: (context, landingscreen, child) => Scaffold(
        body: _getChildBasedOnTab(landingscreen.index),
        bottomNavigationBar: _bottomNavigationBar(landingscreen, context),
      ),
    );
  }

  Widget _getChildBasedOnTab(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ExploreScreen();
      case 2:
        return const ProfilePage();
      default:
        return const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        );
    }
  }

  Widget _bottomNavigationBar(
      LandingService landingService, BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).secondaryHeaderColor,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).home),
        BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: AppLocalizations.of(context).explore),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).profile),
      ],
      currentIndex: landingService.index,
      onTap: (value) => landingService.updateIndex(value),
    );
  }
}
