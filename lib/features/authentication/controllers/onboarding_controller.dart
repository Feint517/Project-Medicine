import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_med/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //? variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0
      .obs; //! means "obsever", listens to the stream and change the disign without stfl widgets

  //? update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //? jump to the new specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value =
        index; //! because it's of type Rx<int> we have to put .value
    pageController.jumpTo(index);
  }

  //? update current index and jump to next page
  void nextPage() {
    //! change the value depending on how many pages we do have
    if (currentPageIndex.value == 1) {
      Get.offAll(() => const LoginScreen());
      //?  Using a widget function instead of a widget fully guarantees that the widget and its controllers will be removed from memory when they are no longer used.
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //? update current index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2; //! values start from 0, 1, 2....
    pageController.jumpToPage(2);
  }
}
