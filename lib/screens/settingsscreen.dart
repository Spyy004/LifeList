import 'package:flutter/material.dart';
import 'package:lifelist/components/index.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';

import '../constants/index.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsService>(
            builder: (context, settingModal, child) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        navigationService.navigatePop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  SizedBox(
                    width: Sizes.screenWidth(context) * 0.02,
                  ),
                  CustomText(
                      text: SETTINGS,
                      style: Theme.of(context).textTheme.displayLarge),
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
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 20,
                ),
                title: CustomText(
                  text: APP_VERSION,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                subtitle: CustomText(
                  text: appVersion,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.code,
                  size: 20,
                ),
                title: CustomText(
                  text: SOURCE_CODE,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () async {
                 const url = 'https://github.com/Spyy004/LifeList';
                 final uri = Uri.parse(url);
                 if (await canLaunchUrl(uri)) {
                   await launchUrl(uri);
                 } else {
                   throw 'Could not launch $url';
                 }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  size: 20,
                ),
                title: CustomText(
                  text: CLEAR_DATA,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Consumer<SettingsService>(
                        builder: (context, value, child) => AlertDialog(
                          backgroundColor: Theme.of(context).primaryColor,
                          title: const Text(CLEAR_DATA_CONFIRM),
                          content: const Text(CLEAR_DATA_SUBTITLE),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).secondaryHeaderColor),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: CustomText(
                                style: Theme.of(context).textTheme.labelLarge,
                                text: CANCEL,
                              ),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor),
                                onPressed: () async {
                                  await value.clearData();
                                  navigationService.navigatePop(context);
                                },
                                child: CustomText(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  text: CONFIRM,
                                )),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
