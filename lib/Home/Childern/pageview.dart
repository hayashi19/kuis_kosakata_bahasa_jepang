//> widget
//?= section for general homepage widgets
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Ads/ads_page.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Dictionary/dictionary_page.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/menu_page.dart';

import '../../main_controller.dart';
import '../../Quiz/quiz_page.dart';

class HomePageView extends GetView<MainController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: controller.homeController.pageController.value,
              onPageChanged: (newIndex) {
                controller.homeController.pageIndex.value = newIndex;
              },
              children: const <Widget>[
                QuizPage(),
                DictionaryPage(),
                MenuPage()
              ],
            ),
          ),
          // const SizedBox(height: 16),
          // BannerAdsContainer(
          //   bannerAd: controller.adsController.allBanner,
          // ),
        ],
      ),
    );
  }
}

class HomePageViewDesktop extends GetView<MainController> {
  const HomePageViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
        bottom: 16,
      ),
      child: PageView(
        controller: controller.homeController.pageController.value,
        onPageChanged: (newIndex) {
          controller.homeController.pageIndex.value = newIndex;
        },
        children: const <Widget>[
          QuizPageDesktop(),
          DictionaryPage(),
          MenuPage()
        ],
      ),
    );
  }
}
