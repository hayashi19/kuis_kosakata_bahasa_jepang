import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          ListView(
            children: const <Widget>[
              QuizScore(),
              SizedBox(height: 8),
              SizedBox(height: 8),
              QuizQuestion(),
              SizedBox(height: 8),
              QuizAnswer(),
              SizedBox(height: 8),
              Divider(
                color: Colors.blueGrey,
                height: 36,
                thickness: 4,
              ),
              QuizDropdownMenu(),
              SizedBox(height: 8),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton.icon(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) => const QuizHint(),
                );
                allPageController.adsCountDown++;
                print(allPageController.adsCountDown.value);
                if (allPageController.adsCountDown.value % 3 == 0) {
                  allPageController.loadInterstitialAd();
                }
              },
              icon: const Icon(Icons.help),
              label: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('BERI PETUNJUK'),
              ),
              color: const Color(0xFFBC002D),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScore extends StatelessWidget {
  const QuizScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 4,
          shadowColor: Colors.redAccent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFCB2D3E), Color(0xFFEF473A)],
              ),
            ),
            child: Obx(
              () => Text(
                "SALAH ${allPageController.falseScore}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Obx(
          () => Text(
            allPageController.falseOrTrue.value,
            style: TextStyle(color: allPageController.falseOrTrueColor.value),
          ),
        ),
        Card(
          elevation: 4,
          shadowColor: Colors.greenAccent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFA8E063), Color(0xFF56AB2F)],
              ),
            ),
            child: Obx(
              () => Text(
                "BENAR ${allPageController.trueScore}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            if (allPageController.quizWordList.isEmpty) {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                    semanticsLabel: "Memuat kata . . .",
                  ),
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  // Kanji question
                  Obx(
                    () => Visibility(
                      visible: allPageController.kanjiVisibility.value,
                      child: Obx(
                        () => Text(
                          allPageController
                                  .quizWordList[allPageController.rand.value]
                              ["KanjiCasualPositive"],
                          style: const TextStyle(
                            fontSize: 64,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Romaji question
                  Obx(
                    () => Visibility(
                      visible: allPageController.romajiVisibility.value,
                      child: Obx(
                        () => Text(
                          allPageController
                                  .quizWordList[allPageController.rand.value]
                              ["RomajiCasualPositive"],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bahasa question
                  Obx(
                    () => Visibility(
                      visible: allPageController.bahasaVisibility.value,
                      child: Obx(
                        () => Text(
                          allPageController
                                  .quizWordList[allPageController.rand.value]
                              ["BahasaCasualPositive"],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class QuizSwitch extends StatelessWidget {
  const QuizSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Sembunyikan Bantuan",
              style: TextStyle(fontSize: 16),
            ),
            Obx(
              () => Switch(
                value: allPageController.spellingVisibility.value,
                onChanged: (value) =>
                    allPageController.changeSpellingVisibility(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(
                () => TextField(
                  controller: allPageController.submitTextfield,
                  onEditingComplete: () => allPageController
                      .checkAnswer(allPageController.answerTypeValue.value),
                  decoration: InputDecoration(
                    hintText:
                        "jawab dengan ${allPageController.answerTypeValue.value}",
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            // Set onPressed to get rand number
            onPressed: () => allPageController
                .checkAnswer(allPageController.answerTypeValue.value),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'CHECK',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Josefin Sans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  // Parameter
  String altValue;
  final List<String> altItem;
  final ValueChanged altOnChange;

  // Initialize
  Dropdown(
      {Key? key,
      required this.altItem,
      required this.altValue,
      required this.altOnChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: altValue,
            isExpanded: true,
            onChanged: (String? newValue) {
              altOnChange(newValue);
            },
            items: altItem.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class QuizDropdownMenu extends StatelessWidget {
  const QuizDropdownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Pengaturan kuis",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const QuizSwitch(),
        Row(
          children: <Widget>[
            // Level
            Expanded(
              child: Obx(
                () => Dropdown(
                  altItem: allPageController.levelTypeItem,
                  altValue: allPageController.levelTypeValue.value,
                  altOnChange: (value) {
                    allPageController.levelTypeValue.value = value;
                    allPageController.changeWordType(
                      allPageController.wordTypeValue.value,
                      allPageController.levelTypeValue.value,
                    );
                  },
                ),
              ),
            ),
            // Word Type
            Expanded(
              child: Obx(
                () => Dropdown(
                  altItem: allPageController.wordTypeItem,
                  altValue: allPageController.wordTypeValue.value,
                  altOnChange: (value) {
                    allPageController.wordTypeValue.value = value;
                    allPageController.changeWordType(
                      allPageController.wordTypeValue.value,
                      allPageController.levelTypeValue.value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        // Answer type
        Obx(
          () => Dropdown(
            altItem: allPageController.answerTypeItem,
            altValue: allPageController.answerTypeValue.value,
            altOnChange: (value) {
              allPageController.answerTypeValue.value = value;
              allPageController
                  .wordVisibility(allPageController.answerTypeValue.value);
            },
          ),
        )
      ],
    );
  }
}

class QuizHint extends StatelessWidget {
  const QuizHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                // Content inside the bottom sheet
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Obx(
                      () => Text(
                        "${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualPositive"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualPositive"]}): ${allPageController.quizWordList[allPageController.rand.value]["BahasaCasualPositive"]}",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Konjugasi Umum:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "JPLT Level: ${allPageController.quizWordList[allPageController.rand.value]["Level"]}")),
                Obx(() => Text(
                    "Jenis ${allPageController.wordTypeValue}: ${allPageController.quizWordList[allPageController.rand.value]["WordType"]}")),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "Kasual Negatif: ${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualNegative"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualNegative"]})")),
                Obx(() => Text(
                    "Kasual Lampau: ${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualPast"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualPast"]})")),
                const SizedBox(height: 8),
                Obx(() => Text(
                    "Sopan Posistif: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPolitePositive"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPolitePositive"]})")),
                Obx(() => Text(
                    "Sopan Negatif: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPoliteNegative"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPoliteNegative"]})")),
                Obx(() => Text(
                    "Sopan Lampau: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPolitePast"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPolitePast"]})")),
              ],
            ),
          ),
          // Close button
          ElevatedButton(
            child: const Text("Tutup Petunjuk"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
