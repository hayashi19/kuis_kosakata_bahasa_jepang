// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/custome_button.dart';
import '../../main_controller.dart';

class HintButton extends GetView<MainController> {
  const HintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      margin: const EdgeInsets.all(4),
      borderColor: Theme.of(context).colorScheme.primary,
      child: Text(
        "bantuan?",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () {
        controller.adsController.adsCountDown++;
        if (controller.adsController.adsCountDown.value % 3 == 0) {
          controller.adsController.loadInterstitialAd();
        }
        Get.bottomSheet(
          const HintContainer(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        );
      },
    );
  }
}

class HintContainer extends StatelessWidget {
  const HintContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const <Widget>[
          HintWord(),
          SizedBox(height: 20),
          HintBackButton()
        ],
      ),
    );
  }
}

class HintWord extends StatelessWidget {
  const HintWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const <Widget>[
          LevelWord(),
          SizedBox(height: 10),
          TypeWord(),
          SizedBox(height: 10),
          KanjiWord(),
          SizedBox(height: 10),
          KanaWord(),
          SizedBox(height: 10),
          BahasaWord(),
        ],
      ),
    );
  }
}

class LevelWord extends GetView<MainController> {
  const LevelWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "Level ${controller.quizController.quizWord[controller.quizController.ranNum.value]['level']}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class TypeWord extends GetView<MainController> {
  const TypeWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "Tipe ${controller.quizController.quizWord[controller.quizController.ranNum.value]['type_name']}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class KanaWord extends GetView<MainController> {
  const KanaWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "[${controller.quizController.kana.toString().replaceAll(RegExp(r'[\[\]]'), "")}] ~${controller.quizController.romaji.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class KanjiWord extends GetView<MainController> {
  const KanjiWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.quizController.kanji.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(const TextStyle(fontSize: 64)),
      ),
    );
  }
}

class BahasaWord extends GetView<MainController> {
  const BahasaWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.quizController.bahasa.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class HintBackButton extends StatelessWidget {
  const HintBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      borderColor: Theme.of(context).colorScheme.secondary,
      child: const Center(child: Text("kembali")),
      onTap: () => Get.back(),
    );
  }
}
