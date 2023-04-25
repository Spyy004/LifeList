import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:lifelist/services/index.dart';
import 'package:lifelist/services/pdfservice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/index.dart';
import '../constants/index.dart';
import '../models/index.dart';

class BucketDetailsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  Future<bool> onPop(BuildContext context, singleBucketModel) async {
    await singleBucketModel.clearData();
    navigationService.navigateReset(context, HOME);
    return true;
  }

  BucketDetailsScreen({super.key});
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
          backgroundColor: Theme.of(context).primaryColor,
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
                                  Expanded(
                                    child: CustomText(
                                        text: singleBucketModal
                                            .activeSingleBucket.name
                                            .capitalize(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!),
                                  ),
                                  Consumer<PdfService>(
                                      builder: (context, pdfModel, child) =>
                                          IconButton(
                                              onPressed: () async {
                                                pdfModel.generatePdf(
                                                    singleBucketModal
                                                        .activeSingleBucket);
                                              },
                                              icon: Icon(Icons.download)))
                                ],
                              )
                            : CustomTextField(
                                nameController: nameController,
                                labelText:
                                    singleBucketModal.activeSingleBucket.name,
                                textInputType: TextInputType.name,
                                hintText:
                                    singleBucketModal.activeSingleBucket.name),
                        const SizedBox(height: 16),
                        !singleBucketModal.isEditing
                            ? Text(
                                singleBucketModal.activeSingleBucket.description
                                    .capitalize(),
                                style: const TextStyle(fontSize: 18),
                              )
                            : CustomTextField(
                                nameController: descController,
                                labelText: singleBucketModal
                                    .activeSingleBucket.description,
                                textInputType: TextInputType.name,
                                hintText: singleBucketModal
                                    .activeSingleBucket.description),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (singleBucketModal.isEditing) {
                                  singleBucketModal
                                      .setActiveBucketDeadlineDate(context);
                                }
                              },
                              child: IconTextWidget(
                                  iconData: Icons.calendar_month,
                                  text:
                                      "${singleBucketModal.activeSingleBucket.deadline.year}/${singleBucketModal.activeSingleBucket.deadline.month}/${singleBucketModal.activeSingleBucket.deadline.day}"),
                            ),
                            SizedBox(width: Sizes.screenWidth(context) * 0.2),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (singleBucketModal.isEditing) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Consumer<BucketService>(
                                            builder: (context, value, child) =>
                                                AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .selectCategory),
                                              content: const MyDropdownMenu(
                                                  actions: 'EDIT'),
                                              actions: [
                                                ElevatedButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .secondaryHeaderColor),
                                                    onPressed: () {
                                                      navigationService
                                                          .navigatePop(context);
                                                    },
                                                    child: CustomText(
                                                      text: AppLocalizations.of(
                                                              context)
                                                          .done,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ))
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                },
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
                            ),
                            SizedBox(width: Sizes.screenWidth(context) * 0.2),
                            !singleBucketModal.isEditing
                                ? IconTextWidget(
                                    iconData: singleBucketModal
                                            .activeSingleBucket.isCompleted
                                        ? Icons.check
                                        : Icons.cancel,
                                    text: AppLocalizations.of(context).status)
                                : Column(
                                    children: [
                                      Switch(
                                          activeColor: Theme.of(context)
                                              .secondaryHeaderColor,
                                          value: singleBucketModal
                                              .activeSingleBucket.isCompleted,
                                          onChanged: (val) {
                                            singleBucketModal
                                                .changeCurrentBucketStatus();
                                          }),
                                      CustomText(
                                          text: AppLocalizations.of(context)
                                              .status,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: AppLocalizations.of(context).tasks,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            CustomText(
                                text:
                                    '${taskService.completionPercentage.toInt()}% ${AppLocalizations.of(context).done}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
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
                                      title: !task!.isComplete
                                          ? CustomText(
                                              text: task.name
                                                  .toString()
                                                  .capitalize(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            )
                                          : CustomText(
                                              text: task.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .merge(const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough))),
                                      // Replace with the actual task name
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: !task.isComplete
                                                ? const Icon(Icons.check)
                                                : const Icon(Icons
                                                    .cancel), // Replace with the desired tick-mark icon
                                            onPressed: () async {
                                              await taskService
                                                  .updateSingleTask(task);
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
                                                    msg: AppLocalizations.of(
                                                            context)
                                                        .abucketshouldhaveatleastonetask);
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
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .deleteTask),
                                                      content: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .areyousureyouwanttodeletethistask),
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
                                                            text: AppLocalizations
                                                                    .of(context)
                                                                .cancel,
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
                                                              text: AppLocalizations
                                                                      .of(context)
                                                                  .confirm,
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
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  )
                                : !singleBucketModal.isEditing
                                    ? NeoPopButton(
                                        onTapDown: () async {},
                                        bottomShadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        rightShadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        depth: 5,
                                        onTapUp: () {
                                          singleBucketModal.changeEditStatus();
                                        },
                                        color: Theme.of(context).canvasColor,
                                        shadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        child: CustomText(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          text:
                                              AppLocalizations.of(context).edit,
                                        ),
                                      )
                                    : NeoPopButton(
                                        onTapDown: () async {},
                                        bottomShadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        rightShadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        depth: 5,
                                        onTapUp: () async {
                                          await singleBucketModal.editBucket(
                                              nameController.text,
                                              descController.text,
                                              context);

                                          singleBucketModal.changeEditStatus();
                                        },
                                        color: Theme.of(context).canvasColor,
                                        shadowColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        child: CustomText(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          text:
                                              AppLocalizations.of(context).save,
                                        ),
                                      )),
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
