import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_med/common/widgets/custon_shapes/container/primary_header_container.dart';
import 'package:project_med/features/med/screens/home/widgets/home_appbar.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPrimaryHeaderContainer(
              child: Column(
                children: [
                  //* appbar
                  const HomeAppBar(),
                  const Gap(TSizes.spaceBtwSections),
                  Text(
                    'Just a placeholder',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: TColors.white),
                  ),
                  const Gap(TSizes.spaceBtwSections),
                  const Gap(TSizes.spaceBtwSections),
                ],
              ),
            ),
            const Text('just a place holder 2'),
          ],
        ),
      ),
    );
  }
}


