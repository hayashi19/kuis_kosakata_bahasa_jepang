// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Dictionary/Childern/dictionary_detail.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Quiz/Childern/words.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';
import 'package:lottie/lottie.dart';

class DictionaryList extends GetView<MainController> {
  const DictionaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (controller.dictionaryController.foundWord.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Lottie.asset(controller.themeController.notFound.value),
                const SizedBox(height: 32),
                const Text("kata tidak dapat ditemukan"),
              ],
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(
                right: 4,
                bottom: 4,
              ),
              itemCount: controller.dictionaryController.foundWord.length,
              itemBuilder: (context, index) {
                return SlideInLeft(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.dictionaryController.searchFocuse.value
                            .unfocus();
                        Get.to(
                          () => DictionaryDetail(index: index),
                          transition: Transition.leftToRightWithFade,
                        );
                      },
                      child: DictionaryWord(index: index),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 32);
              },
            );
          }
        },
      ),
    );
  }
}

class DictionaryWord extends StatelessWidget {
  int index;
  DictionaryWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "#$index",
                textAlign: TextAlign.right,
              ),
              LevelWord(index: index),
            ],
          ),
          Divider(
            height: 16,
            color: Theme.of(context).primaryColor,
            thickness: 3,
          ),
          KanaWord(index: index),
          separator,
          KanjiWord(index: index),
          separator,
          const RomajiWord(),
          // separator,
          BahasaWord(index: index),
        ],
      ),
    );
  }

  Widget get separator => const SizedBox(height: 16);
}

class LevelWord extends GetView<MainController> {
  int index;
  LevelWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "Level ${controller.dictionaryController.foundWord[index]['level']}",
        textAlign: TextAlign.left,
      ),
    );
  }
}

class TypeWord extends GetView<MainController> {
  int index;
  TypeWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "Tipe ${controller.dictionaryController.foundWord[index]['type_name']}",
        textAlign: TextAlign.center,
      ),
    );
  }
}

class KanaWord extends GetView<MainController> {
  int index;

  KanaWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "[${controller.dictionaryController.getKana(index).first}] ~${controller.dictionaryController.getRomaji(index).first}",
        textAlign: TextAlign.center,
      ),
    );
  }
}

class KanjiWord extends GetView<MainController> {
  int index;
  KanjiWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.dictionaryController.getKanji(index).first.toString().replaceAll('//', '')}",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(const TextStyle(height: 1, fontSize: 44)),
      ),
    );
  }
}

class BahasaWord extends GetView<MainController> {
  int index;
  BahasaWord({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.dictionaryController.getBahasa(index).toString().toLowerCase()}",
        textAlign: TextAlign.center,
      ),
    );
  }
}
