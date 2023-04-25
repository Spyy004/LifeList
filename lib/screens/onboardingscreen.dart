import 'package:flutter/material.dart';
import 'package:lifelist/neopop/neopop.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/index.dart';
import '../constants/index.dart';

class OnboardingScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Consumer<OnboardingService>(
        builder: (context, onboardingProvider, child) => SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Sizes.paddingSizeLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppLocalizations.of(context).letsgetStarted,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .merge(TextStyle(fontSize: 24)),
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.05,
                ),
                CustomTextField(
                  nameController: firstNameController,
                  labelText: AppLocalizations.of(context).firstName,
                  hintText: AppLocalizations.of(context).joeMama,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.02,
                ),
                CustomTextField(
                  nameController: lastNameController,
                  labelText: AppLocalizations.of(context).lastName,
                  hintText: AppLocalizations.of(context).joeMama,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.02,
                ),
                CustomTextField(
                  nameController: ageController,
                  labelText: AppLocalizations.of(context).age,
                  hintText: AppLocalizations.of(context).sixtyNine,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.4,
                ),
                onboardingProvider.loader == false
                    ? SizedBox(
                        width: Sizes.screenWidth(context),
                        height: Sizes.screenHeight(context) * 0.05,
                        child: NeoPopButton(
                          bottomShadowColor:
                              Theme.of(context).secondaryHeaderColor,
                          rightShadowColor:
                              Theme.of(context).secondaryHeaderColor,
                          animationDuration: const Duration(milliseconds: 300),
                          depth: 5,
                          onTapUp: () {
                            bool nameStatus = onboardingProvider.checkName(
                                firstNameController.text, context);
                            bool lastNameStatus = onboardingProvider.checkName(
                                lastNameController.text, context);
                            bool ageStatus = onboardingProvider.checkAge(
                                int.parse(ageController.text), context);
                            if (nameStatus && lastNameStatus && ageStatus) {
                              onboardingProvider.submitDetails(
                                  firstNameController.text,
                                  lastNameController.text,
                                  ageController.text,
                                  context);
                            }
                          },
                          color: Theme.of(context).canvasColor,
                          shadowColor: Theme.of(context).secondaryHeaderColor,
                          child: CustomText(
                            style: Theme.of(context).textTheme.labelLarge,
                            text: AppLocalizations.of(context).done,
                          ),
                        ),
                      )
                    : SpinKitWave(
                        color: Theme.of(context).secondaryHeaderColor,
                        duration: const Duration(seconds: 1),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
