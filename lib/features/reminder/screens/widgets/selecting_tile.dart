import 'package:flutter/material.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

class SelectingContainer extends StatelessWidget {
  const SelectingContainer({
    super.key,
    required this.name,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

  final String name;
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
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: backgroundColor!.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
