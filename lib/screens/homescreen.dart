import 'package:flutter/material.dart';
import 'package:lifelist/components/empty_page.dart';
import 'package:lifelist/constants/index.dart';
import 'package:lifelist/services/bucketlistservice.dart';
import 'package:provider/provider.dart';
import '../components/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<BucketListService>(
          builder: (context, model, child) => FutureBuilder<void>(
              future: model.getAllBuckets(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.all(Sizes.paddingSizeMedium),
                  child: SingleChildScrollView(
                    //  physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: AppLocalizations.of(context).helloWorld,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            IconButton(
                                onPressed: () {
                                  navigationService.navigateReset(
                                      context, PROFILE);
                                },
                                icon: const Icon(Icons.person))
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
                        model.buckets.isNotEmpty
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
                                itemCount: model.buckets.length,
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
                                              title: const Text(
                                                  DELETE_BUCKET_CONFIRM),
                                              content: const Text(
                                                  DELETE_BUCKET_SUBTITLE),
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
                                                    text: CANCEL,
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
                                                    text: CONFIRM,
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
                                          NAME_ARGS: model.buckets[index]
                                        });
                                      },
                                      elevation: 5,
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: 20,
                                      borderColor:
                                          model.buckets[index]!.isCompleted
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
                                                '${model.buckets[index]?.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                          CustomText(
                                            text: model
                                                .buckets[index]!.description,
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
                            : const Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: EmptyWidget(
                                    title: ZERO_BUCKET_LIST_FOUND,
                                    subTitle: LETS_CREATE_BUCKETLIST,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () {
          navigationService.navigateNext(context, CREATE_BUCKET);
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    ));
  }
}
