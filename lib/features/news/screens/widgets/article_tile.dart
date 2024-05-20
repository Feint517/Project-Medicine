import 'package:flutter/material.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      width: THelperFunctions.screenWidth() * 0.9,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: THelperFunctions.screenWidth() * 0.60,
            height: 100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('title'),
                Text('author name'),
              ],
            ),
          ),
          SizedBox(
            width: THelperFunctions.screenWidth() * 0.25,
            height: 100,
          ),
        ],
      ),
    );
  }
}
