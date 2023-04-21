import 'package:flutter/material.dart';
import 'package:lifelist/components/index.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final Uri _url = Uri.parse(URL);
  Future<void> _launchUrl() async {
    if (await canLaunchUrl(
      _url,
    )) {
      await launchUrl(
        _url,
      );
    } else {
      throw 'Could not launch $_url';
    }
  }

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
                      text: AppLocalizations.of(context).settings,
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
                  text: AppLocalizations.of(context).appVersion,
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
                  text: AppLocalizations.of(context).sourceCode,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: _launchUrl,
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  size: 20,
                ),
                title: CustomText(
                  text: AppLocalizations.of(context).clearData,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Consumer<SettingsService>(
                        builder: (context, value, child) => AlertDialog(
                          backgroundColor: Theme.of(context).primaryColor,
                          title: Text(AppLocalizations.of(context).clearData),
                          content: Text(AppLocalizations.of(context)
                              .areyousureyouwanttoclearalldata),
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
                                text: AppLocalizations.of(context).cancel,
                              ),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor),
                                onPressed: () {
                                  value.clearData();
                                  navigationService.navigatePop(context);
                                },
                                child: CustomText(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  text: AppLocalizations.of(context).confirm,
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
