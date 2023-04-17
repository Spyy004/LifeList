import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/components/empty_page.dart';
import 'package:lifelist/services/index.dart';
import 'package:provider/provider.dart';

import '../components/index.dart';
import '../constants/index.dart';
import '../models/index.dart';

// ignore: must_be_immutable
class BucketDetailsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Future<bool> onPop(BuildContext context, singleBucketModel) async {
    await singleBucketModel.clearData();
    navigationService.navigateReset(context, HOME);
    return true;
  }

  BucketDetailsScreen();
  @override
  Widget build(BuildContext context) {
    final Map<String, Bucket?> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Bucket?>;
    Bucket? bucket = args[NAME_ARGS];
    return Consumer2<BucketService, TaskService>(
      builder: (context, singleBucketModal, taskService, child) => WillPopScope(
        onWillPop: () {
          return onPop(context, singleBucketModal);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: FutureBuilder<void>(
                future: Future.wait([
                  taskService.fetchActiveBucketTaskDetails(
                      bucket!.tasks, bucket),
                  singleBucketModal.setActiveSingleBucket(bucket)
                ]),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !singleBucketModal.isEditing
                            ? Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        singleBucketModal.clearData();
                                        navigationService.navigateReset(
                                            context, HOME);
                                      },
                                      icon: const Icon(Icons.arrow_back)),
                                  Text(
                                      singleBucketModal.activeSingleBucket.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .merge(
                                              const TextStyle(fontSize: 40))),
                                ],
                              )
                            : CustomTextField(
                                nameController: nameController,
                                labelText: NAME_ARGS,
                                textInputType: TextInputType.name,
                                hintText:
                                    singleBucketModal.activeSingleBucket.name),
                        const SizedBox(height: 16),
                        !singleBucketModal.isEditing
                            ? Text(
                                singleBucketModal
                                    .activeSingleBucket.description,
                                style: const TextStyle(fontSize: 18),
                              )
                            : CustomTextField(
                                nameController: descController,
                                labelText: DESCRIPTION,
                                textInputType: TextInputType.name,
                                hintText: singleBucketModal
                                    .activeSingleBucket.description),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconTextWidget(
                                iconData: Icons.calendar_month,
                                text:
                                    "${singleBucketModal.activeSingleBucket.deadline.year}/${singleBucketModal.activeSingleBucket.deadline.month}/${singleBucketModal.activeSingleBucket.deadline.day}"),
                            SizedBox(width: Sizes.screenWidth(context) * 0.2),
                            Expanded(
                              child: IconTextWidget(
                                  iconData: categoryMap[singleBucketModal
                                      .activeSingleBucket.bucketCategory],
                                  text: singleBucketModal
                                      .activeSingleBucket.bucketCategory
                                      .toString()
                                      .split('.')
                                      .last
                                      .toUpperCase()),
                            ),
                            SizedBox(width: Sizes.screenWidth(context) * 0.2),
                            !singleBucketModal.isEditing
                                ? IconTextWidget(
                                    iconData: singleBucketModal
                                            .activeSingleBucket.isCompleted
                                        ? Icons.check
                                        : Icons.cancel,
                                    text: STATUS)
                                : Column(
                                    children: [
                                      Switch(
                                          value: singleBucketModal
                                              .activeSingleBucket.isCompleted,
                                          onChanged: (val) {
                                            singleBucketModal
                                                .changeCurrentBucketStatus();
                                          }),
                                      CustomText(
                                          text: STATUS,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.04,
                        ),
                        CustomText(
                            text: TASKS,
                            style: Theme.of(context).textTheme.displayMedium),
                        const Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        taskService.tasks.isEmpty
                            ? const EmptyWidget(
                                title: ZERO_TASKS,
                                subTitle: LETS_ADD_TASKS,
                                hideBackgroundAnimation: true,
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: taskService.tasks
                                      .length, // Replace with the actual number of tasks in the bucket
                                  itemBuilder: (context, index) {
                                    // Replace `tasks` with the actual list of tasks in the bucket
                                    final task = taskService.tasks[index];

                                    return ListTile(
                                      title: Text(task!
                                          .name), // Replace with the actual task name
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons
                                                .check), // Replace with the desired tick-mark icon
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg: FEATURE_COMING_SOON);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons
                                                .delete), // Replace with the desired delete icon
                                            onPressed: () async {
                                              if (singleBucketModal
                                                      .activeSingleBucket
                                                      .tasks
                                                      .length ==
                                                  1) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        ATLEAST_ONE_TASK_PROMPT);
                                                return;
                                              }
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Consumer<
                                                      BucketService>(
                                                    builder: (context, value,
                                                            child) =>
                                                        AlertDialog(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      title: const Text(
                                                          DELETE_TASK_CONFIRM),
                                                      content: const Text(
                                                          DELETE_TASK_SUBTITLE),
                                                      actions: [
                                                        TextButton(
                                                          style: TextButton.styleFrom(
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .secondaryHeaderColor),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                          child: CustomText(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                            text: CANCEL,
                                                          ),
                                                        ),
                                                        TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor:
                                                                    Theme.of(
                                                                            context)
                                                                        .secondaryHeaderColor),
                                                            onPressed:
                                                                () async {
                                                              await singleBucketModal
                                                                  .deleteTasks(
                                                                      bucket,
                                                                      task.id,
                                                                      singleBucketModal
                                                                          .activeSingleBucket
                                                                          .id);

                                                              await taskService
                                                                  .deleteSingleTask(
                                                                      task.id);
                                                              // ignore: use_build_context_synchronously
                                                              navigationService
                                                                  .navigatePop(
                                                                      context);
                                                            },
                                                            child: CustomText(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                              text: CONFIRM,
                                                            )),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(
                          width: Sizes.screenWidth(context),
                          height: Sizes.screenHeight(context) * 0.05,
                          child: singleBucketModal.loader
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).secondaryHeaderColor,
                                )
                              : !singleBucketModal.isEditing
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .secondaryHeaderColor),
                                      onPressed: () {
                                        singleBucketModal.changeEditStatus();
                                      },
                                      child: CustomText(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        text: "Edit",
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .secondaryHeaderColor),
                                      onPressed: () async {
                                        await singleBucketModal.editBucket(
                                            nameController.text,
                                            descController.text);

                                        singleBucketModal.changeEditStatus();
                                      },
                                      child: CustomText(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        text: "Save",
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
