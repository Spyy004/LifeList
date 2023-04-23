import 'package:flutter/material.dart';
import 'package:lifelist/models/index.dart';
import 'package:lifelist/neopop/neopop.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/index.dart';
import '../constants/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import '../neopop/widgets/buttons/neopop_button/neopop_button.dart';

// ignore: must_be_immutable
class CreateBucketScreen extends StatelessWidget {
  CreateBucketScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Bucket tempBucket = Bucket();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<CreateBucketService>(
          builder: (context, bucketModel, child) => FutureBuilder<void>(
              future: bucketModel.setActiveSingleBucket(tempBucket),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(Sizes.paddingSizeMedium),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context).createaBucket,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.01,
                        ),
                        Divider(
                          thickness: 1,
                          indent: Sizes.paddingSizeSmall - 6,
                          color: Theme.of(context).dividerColor,
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.05,
                        ),
                        CustomTextField(
                          nameController: titleController,
                          labelText: AppLocalizations.of(context).title,
                          hintText: AppLocalizations.of(context).worldTour,
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.02,
                        ),
                        CustomTextField(
                          nameController: descriptionController,
                          labelText: AppLocalizations.of(context).description,
                          hintText:
                              AppLocalizations.of(context).kickingOffDreams,
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.02,
                        ),
                        const MyDropdownMenu(actions: 'CREATE'),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.02,
                        ),
                        ListTile(
                            title: CustomText(
                                text: AppLocalizations.of(context).completed,
                                style: Theme.of(context).textTheme.bodyLarge),
                            trailing: FlutterSwitch(
                                activeColor:
                                    Theme.of(context).secondaryHeaderColor,
                                value:
                                    bucketModel.activeSingleBucket.isCompleted,
                                onToggle: (val) {
                                  bucketModel.changeCurrentBucketStatus();
                                })),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.02,
                        ),
                        ListTile(
                            title: CustomText(
                                text: AppLocalizations.of(context).tasks,
                                style: Theme.of(context).textTheme.bodyLarge),
                            subtitle: Text(
                              "${bucketModel.activeBucketTasks.length} created",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 35,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: [
                                        Consumer<CreateBucketService>(
                                          builder: (context, bucketModel1, child) =>
                                              SizedBox(
                                            height:
                                                Sizes.screenHeight(context) * 0.8,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    CustomText(
                                                        text: AppLocalizations.of(
                                                                context)
                                                            .addTasks,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium),
                                                    ListView.builder(
                                                      controller:
                                                          ScrollController(),
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: bucketModel1
                                                          .activeBucketTasks.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          title: Text(bucketModel1
                                                              .activeBucketTasks[
                                                                  index]
                                                              .name),
                                                          trailing: IconButton(
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            onPressed: () {
                                                              bucketModel1
                                                                  .deleteTaskFromActiveBucket(
                                                                      index);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    InstagramMessageBar(
                                                        onSendMessage: (message) {
                                                      if (message.length < 3) {
                                                        Fluttertoast.showToast(
                                                            msg: AppLocalizations
                                                                    .of(context)
                                                                .taskNameTooShort);
                                                        return;
                                                      }
                                                      bucketModel1
                                                          .addTaskInActiveBucket(
                                                              message);
                                                    }),
                                                    SizedBox(
                                                      height: Sizes.screenHeight(
                                                              context) *
                                                          0.6,
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 20,
                                          right: 20,
                                          child: SizedBox(
                                                  width: Sizes.screenWidth(
                                                      context),
                                                  height: Sizes.screenHeight(
                                                          context) *
                                                      0.05,
                                                  // child: ElevatedButton(
                                                  //   style: ElevatedButton.styleFrom(
                                                  //       backgroundColor: Theme
                                                  //               .of(context)
                                                  //           .secondaryHeaderColor),
                                                  //   onPressed: () async {
                                                  //     navigationService
                                                  //         .navigatePop(context);
                                                  //   },
                                                  //   child: CustomText(
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .labelLarge,
                                                  //     text: AppLocalizations.of(
                                                  //             context)
                                                  //         .done,
                                                  //   ),
                                                  // ),
                                                  child: NeoPopButton(
                                                    bottomShadowColor: Theme.of(
                                                            context)
                                                        .secondaryHeaderColor,
                                                    rightShadowColor: Theme.of(
                                                            context)
                                                        .secondaryHeaderColor,
                                                    animationDuration:
                                                        const Duration(
                                                            milliseconds: 300),
                                                    depth: 5,
                                                    onTapUp: () async {
                                                      navigationService
                                                          .navigatePop(context);
                                                    },
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    shadowColor: Theme.of(
                                                            context)
                                                        .secondaryHeaderColor,
                                                    child: CustomText(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                      text: AppLocalizations.of(
                                                              context)
                                                          .done,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )),
                        ListTile(
                          title: CustomText(
                              text: AppLocalizations.of(context).addDeadline,
                              style: Theme.of(context).textTheme.bodyLarge),
                          trailing: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              bucketModel.setActiveBucketDeadlineDate(context);
                            },
                          ),
                          subtitle: Text(
                              "${bucketModel.activeSingleBucket.deadline.year}/${bucketModel.activeSingleBucket.deadline.month}/${bucketModel.activeSingleBucket.deadline.day}"),
                        ),
                        SizedBox(
                          height: 0.02 * Sizes.screenHeight(context),
                        ),
                        ListTile(
                            title: CustomText(
                                text: AppLocalizations.of(context).addToCalendar,
                                style: Theme.of(context).textTheme.bodyLarge),
                            trailing: FlutterSwitch(
                                activeColor:
                                    Theme.of(context).secondaryHeaderColor,
                                value: bucketModel.syncCalendar,
                                onToggle: (val) {
                                  bucketModel.changeCalendarSyncStatus();
                                })),
                        SizedBox(
                          height: 0.04 * Sizes.screenHeight(context),
                        ),
                        SizedBox(
                          width: Sizes.screenWidth(context),
                          height: Sizes.screenHeight(context) * 0.05,
                          child: NeoPopButton(
                            onTapDown: () async {},
                            bottomShadowColor:
                                Theme.of(context).secondaryHeaderColor,
                            rightShadowColor:
                                Theme.of(context).secondaryHeaderColor,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            depth: 5,
                            onTapUp: () async {
                              bucketModel
                                  .setActiveBucketName(titleController.text);
                              bucketModel.setActiveDescriptionName(
                                  descriptionController.text);
                              await bucketModel.validateInputs(context);
                              bucketModel.clearData();
                            },
                            color: Theme.of(context).primaryColor,
                            shadowColor: Theme.of(context).secondaryHeaderColor,
                            child: CustomText(
                              style: Theme.of(context).textTheme.labelLarge,
                              text: AppLocalizations.of(context).create,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    ));
  }
}
