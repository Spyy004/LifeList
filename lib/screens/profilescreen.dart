import 'package:flutter/material.dart';
import 'package:lifelist/neopop/widgets/buttons/neopop_button/neopop_button.dart';
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
      bottomNavigationBar: const CustomBottomBar(),
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
                        child: NeoPopButton(
                          onTapDown: () {
                            // navigationService.navigateNext(context, SETTINGS);
                          },
                          bottomShadowColor:
                              Theme.of(context).secondaryHeaderColor,
                          rightShadowColor:
                              Theme.of(context).secondaryHeaderColor,
                          animationDuration: const Duration(milliseconds: 300),
                          depth: 5,
                          onTapUp: () {
                            navigationService.navigateNext(context, SETTINGS);
                          },
                          color: Theme.of(context).canvasColor,
                          shadowColor: Theme.of(context).secondaryHeaderColor,
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
