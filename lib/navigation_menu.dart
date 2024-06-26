import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/features/med/screens/home/home.dart';
import 'package:project_med/features/personalization/screens/settings/settings.dart';
import 'package:project_med/features/reminder/controllers/reminder_controller.dart';
import 'package:project_med/features/reminder/screens/medication_reminder.dart';
import 'package:project_med/features/search/controllers/search_controller.dart';
import 'package:project_med/features/search/screens/search_page.dart';
import 'package:project_med/utils/constants/colors.dart';
import 'package:project_med/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final reminder = Get.put(ReminderController());
    final search = Get.put(DrugSearchController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(
              icon: Icon(
                Iconsax.home,
                color: TColors.primary,
              ),
              label: 'Home',
            ),
            GestureDetector(
              onTapCancel: () {
                search.searched.value = false;
              },
              child: const NavigationDestination(
                icon: Icon(
                  Iconsax.search_normal,
                  color: TColors.primary,
                ),
                label: 'Search',
              ),
            ),
            GestureDetector(
              onTapCancel: () {
                DateTime today = DateTime.now();
                var formatted = DateTime(today.year, today.month, today.day)
                    .millisecondsSinceEpoch;
                reminder.fetchTreatmentsByDate(convertedDate: formatted);
              },
              child: const NavigationDestination(
                icon: Icon(
                  Iconsax.bag_happy,
                  color: TColors.primary,
                ),
                label: 'Medication',
              ),
            ),
            const NavigationDestination(
              icon: Icon(
                Iconsax.user,
                color: TColors.primary,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const SearchPage(),
    const MedReminderScreen(),
    const SettingsScreen(),
  ];
}
