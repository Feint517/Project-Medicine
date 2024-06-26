import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class InteractionInfoTile extends StatelessWidget {
  const InteractionInfoTile({
    super.key,
    required this.drug1,
    required this.drug2,
    required this.explanation,
  });

  final String drug1;
  final String drug2;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: THelperFunctions.screenWidth() * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: TColors.primary,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(drug1, style: Theme.of(context).textTheme.titleSmall),
                const Icon(
                  Iconsax.danger,
                  color: Colors.red,
                ),
                Text(drug2, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const Gap(TSizes.spaceBtwItems / 2),
            Text(
              'Explanation:',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: Colors.green),
            ),
            Text(explanation, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
