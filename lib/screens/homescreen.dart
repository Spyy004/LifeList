import 'package:flutter/material.dart';
import 'package:lifelist/components/empty_page.dart';
import 'package:lifelist/constants/index.dart';
import 'package:provider/provider.dart';
import '../components/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: const CustomBottomBar(),
      body: SafeArea(
        child: Consumer<BucketListService>(
          builder: (context, bucketModel, child) => FutureBuilder<void>(
              future: bucketModel.getAllBuckets(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(Sizes.paddingSizeMedium),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context).home,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Divider(
                          thickness: 1,
                          indent: Sizes.paddingSizeSmall - 6,
                          color: Theme.of(context).dividerColor,
                        ),
                        SizedBox(
                          height: Sizes.screenHeight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Consumer2<FilterService,
                                          BucketListService>(
                                        builder: (context, filterModel,
                                                bucket2model, child) =>
                                            SizedBox(
                                          height:
                                              Sizes.screenHeight(context) * 0.9,
                                          width: Sizes.screenWidth(context),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: AppLocalizations.of(
                                                            context)
                                                        .status,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  ListTile(
                                                    title: CustomText(
                                                      text: AppLocalizations.of(
                                                              context)
                                                          .completed,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    leading: Checkbox(
                                                      value: filterModel
                                                          .currentStatus,
                                                      activeColor: Theme.of(
                                                              context)
                                                          .secondaryHeaderColor,
                                                      onChanged: (value) {
                                                        filterModel
                                                            .toggleStatus(
                                                                value!);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  CustomText(
                                                    text: AppLocalizations.of(
                                                            context)
                                                        .selectCategory,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        categories.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final category =
                                                          categories[index];
                                                      return FilterChip(
                                                        label: Text(category),
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        selectedColor: Theme.of(
                                                                context)
                                                            .secondaryHeaderColor,
                                                        selected: filterModel
                                                            .currentCategories
                                                            .contains(
                                                                stringToBucketCategory[
                                                                    category]),
                                                        onSelected: (selected) {
                                                          filterModel.toggleCategory(
                                                              stringToBucketCategory[
                                                                  category]!);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .secondaryHeaderColor,
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: CustomText(
                                                          text: AppLocalizations
                                                                  .of(context)
                                                              .cancel,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: Sizes
                                                              .paddingSizeLarge),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .secondaryHeaderColor,
                                                        ),
                                                        onPressed: () {
                                                          bucket2model.filterBuckets(
                                                              filterModel
                                                                  .currentCategories,
                                                              filterModel
                                                                  .currentStatus);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: CustomText(
                                                          text: AppLocalizations
                                                                  .of(context)
                                                              .filter,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: Sizes
                                                              .paddingSizeLarge),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .secondaryHeaderColor,
                                                        ),
                                                        onPressed: () {
                                                          filterModel
                                                              .resetFilters();
                                                          bucket2model
                                                              .resetFilter();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: CustomText(
                                                          text: AppLocalizations
                                                                  .of(context)
                                                              .reset,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    ],
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
                                icon: Icon(Icons.filter_list))
                          ],
                        ),
                         SizedBox(
                          height: Sizes.screenHeight(context) * 0.03,
                        ),
                        
                        bucketModel.filteredBuckets.isNotEmpty
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemCount: bucketModel.filteredBuckets.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Consumer<BucketListService>(
                                            builder:
                                                (context, bucketlist, child) =>
                                                    AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .deleteBucket),
                                              content: Text(AppLocalizations.of(
                                                      context)
                                                  .areyousureyouwanttodeletethisbucket),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .secondaryHeaderColor),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: CustomText(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                    text: AppLocalizations.of(
                                                            context)
                                                        .cancel,
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .secondaryHeaderColor),
                                                  onPressed: () async {
                                                    await bucketlist
                                                        .deleteBucket(bucketlist
                                                            .buckets[index]!);
                                                    // ignore: use_build_context_synchronously
                                                    navigationService
                                                        .navigatePop(context);
                                                  },
                                                  child: CustomText(
                                                    style: Theme.of(context)
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
                                    child: CustomCard(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, SINGLE_BUCKET, arguments: {
                                          NAME_ARGS:
                                              bucketModel.filteredBuckets[index]
                                        });
                                      },
                                      elevation: 5,
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: 20,
                                      borderColor: bucketModel
                                              .filteredBuckets[index]!
                                              .isCompleted
                                          ? Theme.of(context)
                                              .secondaryHeaderColor
                                          : Colors.grey,
                                      borderWidth: 0.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text:
                                                '${bucketModel.filteredBuckets[index]?.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                          CustomText(
                                            text: bucketModel
                                                .filteredBuckets[index]!
                                                .description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: EmptyWidget(
                                    title: AppLocalizations.of(context)
                                        .zeroBucketListfound,
                                    subTitle: AppLocalizations.of(context)
                                        .letscreatesomebucketLists,
                                    hideBackgroundAnimation: true,
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
      floatingActionButton: Consumer<BucketListService>(
        builder: (context, bucketlist, child) => FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          onPressed: () {
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
