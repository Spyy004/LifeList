import 'package:flutter/material.dart';
import 'package:lifelist/models/index.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/index.dart';
import '../constants/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                        const MyDropdownMenu(),
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
                                    return Consumer<CreateBucketService>(
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
                                                SizedBox(
                                                  width: Sizes.screenWidth(
                                                      context),
                                                  height: Sizes.screenHeight(
                                                          context) *
                                                      0.05,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .secondaryHeaderColor),
                                                    onPressed: () async {
                                                      navigationService
                                                          .navigatePop(context);
                                                    },
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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
                          width: Sizes.screenWidth(context),
                          height: Sizes.screenHeight(context) * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).secondaryHeaderColor),
                            onPressed: () async {
                              bucketModel
                                  .setActiveBucketName(titleController.text);
                              bucketModel.setActiveDescriptionName(
                                  descriptionController.text);
                              await bucketModel.validateInputs(context);
                              bucketModel.clearData();
                            },
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

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  late String? selectedItem = null;
  final List<String> _items = [
    TRAVEL,
    FINANCE,
    ADVENTURE,
    CAREER,
    FITNESS,
    PERSONALITY_DEVELOPMENT,
    RELATIONSHIPS
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set width to screen width
      padding: const EdgeInsets.all(5.0), // Add padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Add border radius
        border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 0.3), // Add border color
      ),
      child: Consumer<CreateBucketService>(
        builder: (context, bucketModel, child) => DropdownButton<String>(
          hint: Text(AppLocalizations.of(context).selectCategory,
              style: Theme.of(context).textTheme.bodyLarge),
          iconEnabledColor: Colors.white,
          value: selectedItem,
          onChanged: (newValue) {
            selectedItem = newValue!;
            bucketModel.setActiveBucketType(selectedItem!);
          },
          items: _items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          isExpanded: true,
          underline: Container(), // Make the dropdown menu expand to full width
        ),
      ),
    );
  }
}
