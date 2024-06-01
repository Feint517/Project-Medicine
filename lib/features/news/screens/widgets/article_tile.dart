import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/features/news/controllers/news_controller.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    this.author,
    required this.title,
    required this.url,
    this.urlToImage,
  });

  final String? author;
  final String title;
  final String url;
  final String? urlToImage;

  @override
  Widget build(BuildContext context) {
    final controller = NewsController.instance;
    bool hasAuthor = true;
    if (author == null || author!.isEmpty) {
      hasAuthor = false;
    }
    return GestureDetector(
      onDoubleTap: () {
        if (kDebugMode) {
          print('author = $author');
          print('title = $title');
          print('url = $url');
          print('urlToImage = $urlToImage');
          print('urlToImage.isEmpty? = ${urlToImage!.isEmpty}');
          print('===========================');
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: TSizes.sm),
        width: THelperFunctions.screenWidth() * 0.5,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.75,
            color: TColors.primary,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: SizedBox(
                width: THelperFunctions.screenWidth() * 0.60,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      THelperFunctions.truncateText(title, 150),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        hasAuthor
                            ? Text(
                                THelperFunctions.truncateText(
                                  author!.toLowerCase(),
                                  20,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: TColors.primary),
                              )
                            : const SizedBox(),
                        Container(
                          height: 33,
                          width: 33,
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                controller.launchingUrl(url);
                              },
                              icon: const Icon(
                                Iconsax.global_search,
                                size: 17,
                                color: TColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: THelperFunctions.screenWidth() * 0.23,
              height: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  fit: BoxFit.fitHeight,
                  urlToImage!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
