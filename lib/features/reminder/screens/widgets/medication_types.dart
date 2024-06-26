import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

class MedicationTypes extends StatelessWidget {
  const MedicationTypes({
    super.key,
    required this.image,
    required this.title,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

  final String image, title;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: TSizes.spaceBtwItems,
        ),
        child: Column(
          children: [
            Container(
              width: 110,
              height: 110,
              padding: const EdgeInsets.all(
                TSizes.sm / 2,
              ),
              decoration: BoxDecoration(
                color: backgroundColor!.withOpacity(0.7),
                border: Border.all(color: TColors.primary),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(TSizes.spaceBtwItems / 2),
            SizedBox(
              width: 90,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
