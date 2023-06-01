// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../main_controller.dart';
import 'Childern/botnav.dart';
import 'Childern/pageview.dart';

class HomePage extends GetView<MainController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.asset(controller.themeController.loading.value),
          );
        } else {
          //?= check the specific platform
          if (GetPlatform.isMobile ||
              (GetPlatform.isMobile && GetPlatform.isWeb)) {
            return const HomePageMobile();
          } else if (GetPlatform.isDesktop ||
              (GetPlatform.isDesktop && GetPlatform.isWeb)) {
            return const HomePageDesktop();
          } else {
            return const HomePageUnsupport();
          }
        }
      }),
    );
  }
}

//> homepage type
class HomePageMobile extends GetView<MainController> {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + 16,
        top: MediaQuery.of(context).padding.top + 16,
        right: MediaQuery.of(context).padding.right + 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: HomePageView()),
        bottomNavigationBar: HomeNavigationBar(),
      ),
    );
  }
}

class HomePageDesktop extends GetView<MainController> {
  const HomePageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + 16,
        top: MediaQuery.of(context).padding.top + 16,
        right: MediaQuery.of(context).padding.right + 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const <Widget>[
              HomeNavigationBar(),
              SizedBox(height: 16),
              Expanded(child: HomePageViewDesktop()),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageUnsupport extends StatelessWidget {
  const HomePageUnsupport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("This device is not yet supported."),
      ),
    );
  }
}
