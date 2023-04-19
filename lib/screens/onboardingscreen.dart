import 'package:flutter/material.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';

import '../components/index.dart';
import '../constants/index.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
                  text: LETS_GET_STARTED,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.05,
                ),
                CustomTextField(
                  nameController: firstNameController,
                  labelText: FIRST_NAME,
                  hintText: JOE_MAMA,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.02,
                ),
                CustomTextField(
                  nameController: lastNameController,
                  labelText: LAST_NAME,
                  hintText: JOE_MAMA,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.02,
                ),
                CustomTextField(
                  nameController: ageController,
                  labelText: AGE,
                  hintText: AGE_NO,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: Sizes.screenHeight(context) * 0.4,
                ),
                onboardingProvider.loader == false
                    ? SizedBox(
                        width: Sizes.screenWidth(context),
                        height: Sizes.screenHeight(context) * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor),
                          onPressed: () {
                            bool nameStatus = onboardingProvider
                                .checkName(firstNameController.text);
                            bool lastNameStatus = onboardingProvider
                                .checkName(lastNameController.text);
                            bool ageStatus = onboardingProvider
                                .checkAge(int.parse(ageController.text));
                            if (nameStatus && lastNameStatus && ageStatus) {
                              onboardingProvider.submitDetails(
                                  firstNameController.text,
                                  lastNameController.text,
                                  ageController.text,
                                  context);
                            }
                          },
                          child: CustomText(
                            style: Theme.of(context).textTheme.labelLarge,
                            text: "Done",
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
