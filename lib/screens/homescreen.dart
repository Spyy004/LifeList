import 'package:flutter/material.dart';
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
      bottomNavigationBar: Consumer<BucketListService>(
        builder: (context, value, child) => 
         CustomBottomBar(bucketListService:value)),
      body: SafeArea(
        child: Consumer<BucketListService>(
          builder: (context, bucketModel, child) => FutureBuilder<void>(
              future: bucketModel.getAllBuckets(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(Sizes.paddingSizeMedium),
                  child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          pinned: true,
                          expandedHeight: 70,
                          elevation: 0,
                          title: CustomText(
                            text: AppLocalizations.of(context).home,
                            style: Theme.of(context).textTheme.displayLarge,
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
                          actions: [
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Theme.of(context).primaryColor,
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
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 0.02 * Sizes.screenHeight(context),
                          ),
                        ),
                        bucketModel.filteredBuckets.isNotEmpty
                            ? SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                    childCount:
                                        bucketModel.filteredBuckets.length,
                                    (context, index) => InkWell(
                                          onLongPress: () {
                                            showDialog(
                                              
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Consumer<
                                                    BucketListService>(
                                                  builder: (context, bucketlist,
                                                          child) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .deleteBucket),
                                                    content: Text(AppLocalizations
                                                            .of(context)
                                                        .areyousureyouwanttodeletethisbucket),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .secondaryHeaderColor),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        child: CustomText(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                          text: AppLocalizations
                                                                  .of(context)
                                                              .cancel,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .secondaryHeaderColor),
                                                        onPressed: () async {
                                                          await bucketlist
                                                              .deleteBucket(
                                                                  bucketlist
                                                                          .buckets[
                                                                      index]!);
                                                          // ignore: use_build_context_synchronously
                                                          navigationService
                                                              .navigatePop(
                                                                  context);
                                                        },
                                                        child: CustomText(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                          text: AppLocalizations
                                                                  .of(context)
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
                                                  context, SINGLE_BUCKET,
                                                  arguments: {
                                                    NAME_ARGS: bucketModel
                                                        .filteredBuckets[index]
                                                  });
                                            },
                                            elevation: 5,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                Center(
                                                  child: CustomText(
                                                    text:
                                                        '${bucketModel.filteredBuckets[index]?.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  ),
                                                ),
                                                CustomText(
                                                  text: bucketModel
                                                      .filteredBuckets[index]!
                                                      .description,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                                SizedBox(
                                                  height: 0.02 *
                                                      Sizes.screenHeight(
                                                          context),
                                                ),
                                                 Icon(
                      
                                                        categoryMap[bucketModel
                                                                .filteredBuckets[
                                                            index]!.bucketCategory]!,
                                                            color: Theme.of(context).secondaryHeaderColor,
                                                            size: 30,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        )),
                              )
                            : SliverToBoxAdapter(
                                child: Center(
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
                              ),
                      ]),
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
