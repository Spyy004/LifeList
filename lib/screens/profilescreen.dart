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
      body: Consumer<UserService>(
        builder: (context, userModel, child) => FutureBuilder<void>(
            future: userModel.getUser(),
            builder: (context, snapshot) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppLocalizations.of(context).profile,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          IconButton(
                              onPressed: () {
                                navigationService.navigatePop(context);
                              },
                              icon: const Icon(Icons.dashboard))
                        ],
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
                          text:"${AppLocalizations.of(context).name}: ${userModel.user.firstName} ${userModel.user.lastName} ",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight(context) * 0.02,
                      ),
                      Center(
                        child: CustomText(
                          text:'${AppLocalizations.of(context).age}: ${userModel.user.age}',
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
