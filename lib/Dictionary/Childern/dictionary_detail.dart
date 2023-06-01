// ignore_for_file: must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:lottie/lottie.dart';

import '../../Ads/ads_page.dart';
import '../../Widgets/custome_button.dart';
import '../../main_controller.dart';

class DictionaryDetail extends GetView<MainController> {
  int index;
  DictionaryDetail({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).padding.left + 32,
                top: MediaQuery.of(context).padding.top + 32,
                bottom: MediaQuery.of(context).padding.bottom + 16,
                right: MediaQuery.of(context).padding.right + 32,
              ),
              children: <Widget>[
                DictionaryDetailWord(index: index),
                separator,
                DictionaryLevelType(index: index),
                Divider(
                  height: 64,
                  color: Theme.of(context).primaryColor,
                  thickness: 4,
                ),
                DictionaryDetailPhrase(mainIndex: index)
              ],
            ),
          ),
          // (GetPlatform.isAndroid && !GetPlatform.isWeb)
          //     ? BannerAdsContainer(
          //         bannerAd: controller.adsController.dictionaryBanner,
          //       )
          //     : Container(),
          separator,
          const BackButton()
        ],
      ),
    );
  }

  Widget get separator => const SizedBox(height: 16);
}

//> word
class DictionaryDetailWord extends StatelessWidget {
  int index;
  DictionaryDetailWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          KanjiWord(index: index),
          separator,
          KanaWord(index: index),
          separator,
          BahasaWord(index: index),
        ],
      ),
    );
  }

  Widget get separator => const SizedBox(height: 16);
}

class KanaWord extends GetView<MainController> {
  int index;
  KanaWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "[${controller.dictionaryController.getKana(index).toString().replaceAll(RegExp(r'[\[\]]'), "")}] ~${controller.dictionaryController.getRomaji(index).toString().replaceAll(RegExp(r'[\[\]]'), "")}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class KanjiWord extends GetView<MainController> {
  int index;
  KanjiWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.dictionaryController.getKanji(index).toString().replaceAll(RegExp(r'([\[\]])|(\/+)'), "")}",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(const TextStyle(fontSize: 64)),
      ),
    );
  }
}

class BahasaWord extends GetView<MainController> {
  int index;
  BahasaWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "${controller.dictionaryController.getBahasa(index).toString().replaceAll(RegExp(r'[\[\]]'), "")}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + 16,
        bottom: MediaQuery.of(context).padding.bottom + 32,
        right: MediaQuery.of(context).padding.right + 16,
      ),
      child: const Center(child: Text("kembali")),
      onTap: () => Get.back(),
    );
  }
}

//> level type
class DictionaryLevelType extends StatelessWidget {
  int index;
  DictionaryLevelType({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LevelWord(index: index),
          separator,
          TypeWord(index: index),
        ],
      ),
    );
  }

  Widget get separator => const SizedBox(height: 16);
}

class LevelWord extends GetView<MainController> {
  int index;
  LevelWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        "Level ${controller.dictionaryController.foundWord[index]['level']}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class TypeWord extends GetView<MainController> {
  int index;
  TypeWord({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.dictionaryController.type(
        controller.databaseController.database!,
        controller.dictionaryController.getKanji(index).toSet().first,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Map> result = List<Map>.from(snapshot.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Tipe Kata:",
                style: TextStyle(fontSize: 18),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result
                    .map((e) => Text(
                          "➡️ ${e.values.first}",
                          style: const TextStyle(fontSize: 18),
                        ))
                    .toList(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

//> jisho.org
//?= show detail from jisho.org
class DictionaryDetailPhrase extends GetView<MainController> {
  int mainIndex;
  DictionaryDetailPhrase({super.key, required this.mainIndex});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder(
        future: controller.dictionaryController.getTranslation(mainIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Lottie.asset(controller.themeController.loading.value),
                const SizedBox(height: 32),
                const Text("sedang mencari data di jisho.org"),
              ],
            );
          } else if (snapshot.data.toString().contains('found: false')) {
            return notFound;
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Jisho.org",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32),
                ),
                separator,
                //> meaning
                const Text(
                  "Arti",
                  style: TextStyle(fontSize: 24),
                ),
                separator1,
                ListView.separated(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      controller.dictionaryController.wordMeaning().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Text("#${index + 1}"),
                      title: Text(
                        "${controller.dictionaryController.wordMeaning()[index]['definition']}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return separator1;
                  },
                ),
                separator,
                //> other form
                const Text(
                  "Bentuk Lain",
                  style: TextStyle(fontSize: 24),
                ),
                separator1,
                ListView.separated(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      controller.dictionaryController.wordOtherForms().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Text("#${index + 1}"),
                      title: Text(
                        "${controller.dictionaryController.wordOtherForms()[index]['kanji']}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .merge(const TextStyle(fontSize: 20)),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return separator1;
                  },
                ),
                separator,
                //> voice
                const Text(
                  "Suara",
                  style: TextStyle(fontSize: 24),
                ),
                separator1,
                ListView.separated(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dictionaryController.wordAudio().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Text("#${index + 1}"),
                      title: LinkifyText(
                        "${controller.dictionaryController.wordAudio()[index]['uri']}",
                        linkStyle: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                        onTap: (link) async {
                          link.value!.printInfo();
                          await controller.dictionaryController
                              .audioUrl(link.value!);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return separator1;
                  },
                ),
                separator,
                //> link
                const Text(
                  "Link Website",
                  style: TextStyle(fontSize: 24),
                ),
                separator1,
                LinkifyText(
                  '''${controller.dictionaryController.wordUri()}''',
                  linkStyle:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  onTap: (link) async {
                    link.value!.printInfo();
                    await controller.dictionaryController
                        .launchUrl(link.value!);
                  },
                ),
              ],
            );
          } else {
            return notFound;
          }
        },
      ),
    );
  }

  Widget get separator => const SizedBox(height: 16);
  Widget get separator1 => const SizedBox(height: 0);
  Widget get notFound => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Lottie.asset(controller.themeController.notFound.value),
          const SizedBox(height: 32),
          const Text("tidak dapat ditemukan di jisho.org"),
        ],
      );
}
