import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Import Files
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/dictionary.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/quiz.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/setting.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetPlatform.isMobile ? const MobileHomePage() : const DesktopHomePage();
}

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController homePageController = Get.put(AllPageController());
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              onPageChanged: (index) => homePageController.changeIndex(index),
              controller: homePageController.pageViewController,
              children: const <Widget>[
                QuizPage(),
                DictionaryPage(),
                SettingPage(),
              ],
            ),
          ),
          ADS(ad: homePageController.allBanner)
        ],
      ),

      // Bot nav bar contain icon of pages
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: homePageController.currentIndex.value,
            onTap: (index) => homePageController.pageViewController
                .animateToPage(index,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.fastLinearToSlowEaseIn),
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  // Ic kuis
                  icon: Icon(Icons.quiz_rounded),
                  label: "Kuis"),
              BottomNavigationBarItem(
                  // Ic kamus
                  icon: Icon(Icons.library_books_rounded),
                  label: "Kamus"),
              BottomNavigationBarItem(
                  // Ic setting
                  icon: Icon(Icons.app_settings_alt_rounded),
                  label: "Pengaturan"),
            ]),
      ),
    );
  }
}

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello, Desktop!"),
      ),
    );
  }
}

// ignore: must_be_immutable
class ADS extends StatelessWidget {
  AdWithView ad;
  ADS({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
