import 'package:flutter/material.dart';
import 'package:lifelist/constants/sizes.dart';
import 'package:lifelist/controllers/global_controller.dart';
import 'package:lifelist/extensions/string_extensions.dart';
import 'package:lifelist/models/template.dart';
import 'package:lifelist/neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/index.dart';
import '../constants/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  void createBucketFromTemplate(
      BucketService bucketService, BucketTemplate template) {
    bucketService.activeSingleBucket.name = template.title!;
    bucketService.activeSingleBucket.deadline = DateTime.now();
    bucketService.activeSingleBucket.streak = 0;
    bucketService.activeSingleBucket.bucketScope =
        stringToBucketScope[template.scope]!;
    bucketService.activeSingleBucket.description = template.description!;
    bucketService.activeSingleBucket.bucketCategory =
        stringToBucketCategory[template.category]!;
    bucketService.activeSingleBucket.isCompleted = false;
    bucketService.activeBucketTasks = createTasks(template.tasks);
  }

  List<Task> createTasks(List<String>? templateTasks) {
    List<Task> tasks = [];
    for (var i = 0; i < templateTasks!.length; i++) {
      Task newTask = Task();
      newTask.name = templateTasks[i];
      tasks.add(newTask);
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    ExploreService exploreService = Provider.of<ExploreService>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: Consumer<BucketListService>(
          builder: (context, value, child) =>
              CustomBottomBar(bucketListService: value)),
      body: SafeArea(
        child: FutureBuilder<List<BucketTemplate?>>(
            future: exploreService.setTemplates(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitWave(
                  color: Theme.of(context).secondaryHeaderColor,
                ));
              }
              if (snapshot.hasData) {
                return Consumer<ExploreService>(
                    builder: (context, bucketModel, child) => Padding(
                          padding: EdgeInsets.all(Sizes.paddingSizeMedium),
                          child: CustomScrollView(
                              scrollDirection: Axis.vertical,
                              slivers: [
                                SliverAppBar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  pinned: true,
                                  expandedHeight: 70,
                                  elevation: 0,
                                  title: CustomText(
                                    text: 'Explore',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  bottom: PreferredSize(
                                    preferredSize: const Size.fromHeight(1),
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 1,
                                          indent: Sizes.paddingSizeSmall - 6,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 0.02 * Sizes.screenHeight(context),
                                  ),
                                ),
                                snapshot.data!.isNotEmpty
                                    ? SliverGrid(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                mainAxisSpacing: 20,
                                                childAspectRatio: 24 / 9),
                                        delegate: SliverChildBuilderDelegate(
                                            childCount: snapshot.data!.length,
                                            (context, index) => InkWell(
                                                  onLongPress: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Consumer<
                                                            BucketListService>(
                                                          builder: (context,
                                                                  bucketlist,
                                                                  child) =>
                                                              AlertDialog(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            title: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .deleteBucket),
                                                            content: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .areyousureyouwanttodeletethisbucket),
                                                            actions: [
                                                              TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Theme.of(context)
                                                                            .secondaryHeaderColor),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Close the dialog
                                                                },
                                                                child:
                                                                    CustomText(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                  text: AppLocalizations.of(
                                                                          context)
                                                                      .cancel,
                                                                ),
                                                              ),
                                                              TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Theme.of(context)
                                                                            .secondaryHeaderColor),
                                                                onPressed:
                                                                    () async {
                                                                  await bucketlist
                                                                      .deleteBucket(
                                                                          bucketlist
                                                                              .buckets[index]!);
                                                                  // ignore: use_build_context_synchronously
                                                                  navigationService
                                                                      .navigatePop(
                                                                          context);
                                                                },
                                                                child:
                                                                    CustomText(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                  text: AppLocalizations.of(
                                                                          context)
                                                                      .confirm,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      CustomCard(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                              context: context,
                                                              builder: (context) =>
                                                                  Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius: const BorderRadius
                                                                                  .only(
                                                                                topLeft: Radius.circular(20.0),
                                                                                topRight: Radius.circular(20.0),
                                                                              ),
                                                                              color: Theme.of(context)
                                                                                  .primaryColor),
                                                                      height: Sizes
                                                                          .screenHeight(
                                                                              context),
                                                                      width: Sizes
                                                                          .screenWidth(
                                                                              context),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(16.0),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Column(
                                                                              children: [
                                                                                Center(
                                                                                  child: CustomText(
                                                                                    text: '${snapshot.data![index]!.title}',
                                                                                    style: Theme.of(context).textTheme.displayLarge,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: Sizes.paddingSizeSmall,
                                                                                ),
                                                                                Center(
                                                                                  child: CustomText(
                                                                                    text: '',
                                                                                    // snapshot
                                                                                    //     .data![index]!
                                                                                    //     .description!,
                                                                                    style: Theme.of(context).textTheme.bodyLarge,
                                                                                  ),
                                                                                ),
                                                                                Divider(),
                                                                                Center(
                                                                                  child: CustomText(
                                                                                    text: AppLocalizations.of(context).tasks,
                                                                                    // snapshot
                                                                                    //     .data![index]!
                                                                                    //     .description!,
                                                                                    style: Theme.of(context).textTheme.displayMedium,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: Sizes.paddingSizeSmall,
                                                                                ),
                                                                                ListView.builder(
                                                                                    itemCount: snapshot.data![index]?.tasks!.length,
                                                                                    shrinkWrap: true,
                                                                                    itemBuilder: (context, taskIndex) {
                                                                                      final task = snapshot.data![index]?.tasks![taskIndex];
                                                                                      return ListTile(
                                                                                        title: CustomText(
                                                                                          text: task!,
                                                                                          style: Theme.of(context).textTheme.displaySmall,
                                                                                        ),
                                                                                      );
                                                                                    }),
                                                                                SizedBox(
                                                                                  height: Sizes.paddingSizeSmall,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Positioned(
                                                                              bottom: 5,
                                                                              left: 10,
                                                                              right: 10,
                                                                              child: SizedBox(
                                                                                width: Sizes.screenWidth(context),
                                                                                height: Sizes.screenHeight(context) * 0.05,
                                                                                child: NeoPopButton(
                                                                                  onTapDown: () {
                                                                                    // navigationService.navigateNext(context, SETTINGS);
                                                                                  },
                                                                                  bottomShadowColor: Theme.of(context).secondaryHeaderColor,
                                                                                  rightShadowColor: Theme.of(context).secondaryHeaderColor,
                                                                                  animationDuration: const Duration(milliseconds: 300),
                                                                                  depth: 5,
                                                                                  onTapUp: () async {
                                                                                    BucketService bucketService = BucketService();
                                                                                    createBucketFromTemplate(bucketService, snapshot.data![index]!);
                                                                                    await bucketService.addBucketsFromTemplate(bucketService.activeSingleBucket, bucketService.activeBucketTasks, context);
                                                                                    await bucketService.clearData();
                                                                                    await FirebaseService().editCloneCountInDB(snapshot.data![index]!.title);
                                                                                    exploreService.editCloneCountInTemplate(snapshot.data![index]);
                                                                                    navigationService.navigatePop(context);
                                                                                  },
                                                                                  color: Theme.of(context).canvasColor,
                                                                                  shadowColor: Theme.of(context).secondaryHeaderColor,
                                                                                  child: Center(
                                                                                    child: CustomText(
                                                                                      style: Theme.of(context).textTheme.labelLarge,
                                                                                      text: 'Clone Bucket',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )));
                                                        },
                                                        elevation: 5,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius: 20,
                                                        borderColor: snapshot
                                                                .data![index]!
                                                                .isCompleted!
                                                            ? Theme.of(context)
                                                                .secondaryHeaderColor
                                                            : Colors.grey,
                                                        borderWidth: 0.5,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Center(
                                                              child: CustomText(
                                                                text:
                                                                    '${snapshot.data![index]!.title}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displayMedium,
                                                              ),
                                                            ),
                                                            Center(
                                                              child: CustomText(
                                                                text:
                                                                    'hello dwdlwmcdvsnosinvdl',
                                                                // snapshot
                                                                //     .data![index]!
                                                                //     .description!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  Sizes.screenHeight(
                                                                      context),
                                                            ),
                                                            Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  IconTextWidget(
                                                                    iconData:
                                                                        Icons
                                                                            .copy,
                                                                    text:
                                                                        '${snapshot.data![index]?.cloneCount}',
                                                                    iconSize:
                                                                        20,
                                                                    // icon:categoryMap[stringToBucketCategory[ snapshot.data![index]!.category.toString().capitalize()]],
                                                                    //   color: Theme.of(
                                                                    //           context)
                                                                    //       .secondaryHeaderColor),
                                                                  ),
                                                                  IconTextWidget(
                                                                    iconData: categoryMap[stringToBucketCategory[snapshot
                                                                        .data![
                                                                            index]!
                                                                        .category
                                                                        .toString()
                                                                        .capitalize()]],
                                                                    text:
                                                                        'Travel',
                                                                    iconSize:
                                                                        20,
                                                                    // icon:categoryMap[stringToBucketCategory[ snapshot.data![index]!.category.toString().capitalize()]],
                                                                    //   color: Theme.of(
                                                                    //           context)
                                                                    //       .secondaryHeaderColor),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 7,
                                                        top: -2,
                                                        child: Container(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(snapshot
                                                              .data![index]!
                                                              .scope!
                                                              .capitalize()),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      )
                                    : SliverToBoxAdapter(
                                        child: Center(
                                          child: SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: EmptyWidget(
                                              title:
                                                  AppLocalizations.of(context)
                                                      .zeroBucketListfound,
                                              subTitle: AppLocalizations.of(
                                                      context)
                                                  .letscreatesomebucketLists,
                                              hideBackgroundAnimation: true,
                                            ),
                                          ),
                                        ),
                                      ),
                              ]),
                        ));
              }
              return const Center(
                  child: EmptyWidget(
                title: 'Sorry, No templates found',
                subTitle: 'We are working on it',
                hideBackgroundAnimation: true,
              ));
            }),
      ),
      floatingActionButton: Consumer<BucketListService>(
        builder: (context, bucketlist, child) => FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          onPressed: () async {
            bucketlist.toggleAction();
            navigationService.navigateNext(context, CREATE_BUCKET);
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    ));
  }
}
