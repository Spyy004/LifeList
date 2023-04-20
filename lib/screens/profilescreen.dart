import 'package:flutter/material.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';
import '../components/index.dart';
import '../constants/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the UserModel using Provider

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: 
      Consumer<BottomBar>(
        builder: (context, bottomBar, child) => BottomNavigationBar(
          currentIndex: bottomBar.currentIndex,
            onTap: (index) {
              if (index == 0) {
                bottomBar.changeIndex(index);
                navigationService.navigateReset(context, HOME);
              } else if (index == 1) {
                bottomBar.changeIndex(index);
                navigationService.navigateReset(context, PROFILE);
              }
            },
            selectedItemColor: Theme.of(context).secondaryHeaderColor,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context).home),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: AppLocalizations.of(context).profile),
            ]),
      ),
      body: Consumer<UserService>(
        builder: (context, userModel, child) => FutureBuilder<void>(
            future: userModel.getUser(),
            builder: (context, snapshot) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context).profile,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Divider(
                        thickness: 1,
                        indent: Sizes.paddingSizeSmall - 6,
                        color: Theme.of(context).dividerColor,
                      ),
                      SizedBox(
                        height: Sizes.screenHeight(context) * 0.05,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage(PROFILE_IMAGE_ASSET),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight(context) * 0.02,
                      ),
                      Center(
                        child: CustomText(
                          text:
                              "${AppLocalizations.of(context).name}: ${userModel.user.firstName} ${userModel.user.lastName} ",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight(context) * 0.02,
                      ),
                      Center(
                        child: CustomText(
                          text:
                              '${AppLocalizations.of(context).age}: ${userModel.user.age}',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight(context) * 0.4,
                      ),
                      SizedBox(
                        width: Sizes.screenWidth(context),
                        height: Sizes.screenHeight(context) * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor),
                          onPressed: () {
                            navigationService.navigateNext(context, SETTINGS);
                          },
                          child: CustomText(
                            style: Theme.of(context).textTheme.labelLarge,
                            text: AppLocalizations.of(context).settings,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
