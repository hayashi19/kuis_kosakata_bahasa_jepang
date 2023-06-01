// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

class QuizWords extends StatelessWidget {
  const QuizWords({super.key});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const LevelTypeWord(),
          separator,
          const KanaWord(),
          separator,
          const KanjiWord(),
          separator,
          const RomajiWord(),
          separator,
          const BahasaWord(),
        ],
      ),
    );
  }

  Widget get separator => const SizedBox(height: 8);
}

class LevelTypeWord extends GetView<MainController> {
  const LevelTypeWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Obx(
          () => Text(
            "${controller.quizController.quizWord[controller.quizController.ranNum.value]['level']}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => Text(
            "${controller.quizController.quizWord[controller.quizController.ranNum.value]['type']}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );
  }
}

class KanaWord extends GetView<MainController> {
  const KanaWord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Visibility(
          visible: controller.quizController.kanaV.value,
          child: Text(
            "${controller.quizController.kana.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .merge(const TextStyle(height: 1, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

class KanjiWord extends GetView<MainController> {
  const KanjiWord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Visibility(
          visible: controller.quizController.kanjiV.value,
          child: Text(
              "${controller.quizController.kanji.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1!.merge(
                    const TextStyle(
                      height: 1,
                      fontSize: 72,
                      // fontWeight: FontWeight.normal,
                    ),
                  )),
        ),
      ),
    );
  }
}

class RomajiWord extends GetView<MainController> {
  const RomajiWord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Visibility(
          visible: controller.quizController.romajiV.value,
          child: Text(
            "${controller.quizController.romaji.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .merge(const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }
}

class BahasaWord extends GetView<MainController> {
  const BahasaWord({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Visibility(
          visible: controller.quizController.bahasaV.value,
          child: Text(
            "${controller.quizController.bahasa.toString().replaceAll(RegExp(r'[\[\]]'), "")}",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .merge(const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
