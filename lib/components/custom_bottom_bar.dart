import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/index.dart';
import '../services/index.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key, this.bucketListService});
  BucketListService? bucketListService;

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarService>(
      builder: (context, bottomBar, child) => BottomNavigationBar(
        currentIndex: bottomBar.currentIndex,
        onTap: (index) {
          if (index == bottomBar.currentIndex) return;
          if (index == 0) {
            navigationService.navigateReset(context, HOME);
          } else if (index == 1) {
            if (bottomBar.currentIndex == 0) {
              bucketListService!.toggleAction();
            }
            navigationService.navigateReset(context, EXPLORE);
          } else if (index == 2) {
            bucketListService!.toggleAction();
            navigationService.navigateReset(context, PROFILE);
          }
          bottomBar.changeIndex(index);
        },
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).home,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).profile,
          ),
        ],
      ),
    );
  }
}
