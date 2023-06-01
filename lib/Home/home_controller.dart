import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController {
  //> page controller
  var pageController = PageController(initialPage: 0).obs;
  var pageIndex = 0.obs;
  changePage(int newIndex) {
    //[] set the page index to the new one so screen and bot-nav can change
    pageIndex.value = newIndex;
    // [] animate screen to the new index
    pageController.value.animateToPage(
      pageIndex.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutExpo,
    );
  }

  //> bot nav bar container
  var containerOnTap = false.obs;
  changeContainerOnTap() async {
    //[] set the container animation true to play the animation
    containerOnTap.value = true;
    //[] after a delayed the container will change to the original
    await Future.delayed(const Duration(milliseconds: 200)).then(
      (value) => containerOnTap.value = false,
    );
  }
}
