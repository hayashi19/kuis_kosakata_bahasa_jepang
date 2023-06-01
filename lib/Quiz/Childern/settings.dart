import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';

import '../../Widgets/custome_dropdown.dart';
import '../../main_controller.dart';

class QuizSettings extends StatelessWidget {
  const QuizSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        SettingTitle(),
        SizedBox(height: 16),
        SpellToggleButton(),
        SizedBox(height: 16),
        LevelSetting(),
        SizedBox(height: 16),
        WordSetting(),
        SizedBox(height: 16),
        AnswerSetting(),
      ],
    );
  }
}

class SettingTitle extends StatelessWidget {
  const SettingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Pengaturan Quiz", style: TextStyle(fontSize: 24));
  }
}

class SpellToggleButton extends GetView<MainController> {
  const SpellToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      child: Material(
        color: Colors.transparent,
        child: Obx(
          () => SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            activeColor: Theme.of(context).primaryColor,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade700,
            title: Text(
              "Tampilkan ejaan?",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            value: controller.quizController.showSpell.value,
            onChanged: (value) {
              controller.quizController.showSpell.value = value;
              controller.quizController.setQuizWordVisibility(false);
            },
          ),
        ),
      ),
    );
  }
}

class LevelSetting extends GetView<MainController> {
  const LevelSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return CDropdown(
      hint: "Level",
      value: controller.quizController.levelChoice,
      selectedValue: controller.quizController.levelSelected,
      onChange: () {
        controller.quizController.setQuizWordList(
          controller.databaseController.database!,
          '''
          SELECT level, type, type_name, word_list.*
          FROM word_list
          JOIN word_level ON word_list.word = word_level.word
          JOIN word_type ON word_list.word = word_type.word
          JOIN type_list ON word_type.type_code = type_list.type_code
          WHERE (type in ${controller.quizController.typeSelected.map((e) => "'${e.values.first}'")}) 
          AND (level in ${controller.quizController.levelSelected.map((e) => "'${e.values.first}'")})
          GROUP BY word_list.word
          ''',
          controller.quizController.quizWord,
        );
      },
    );
  }
}

class WordSetting extends GetView<MainController> {
  const WordSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return CDropdown(
      hint: "Jenis",
      value: controller.quizController.typeChoice,
      selectedValue: controller.quizController.typeSelected,
      onChange: () {
        controller.quizController.setQuizWordList(
          controller.databaseController.database!,
          '''
          SELECT level, type, type_name, word_list.*
          FROM word_list
          JOIN word_level ON word_list.word = word_level.word
          JOIN word_type ON word_list.word = word_type.word
          JOIN type_list ON word_type.type_code = type_list.type_code
          WHERE (type in ${controller.quizController.typeSelected.map((e) => "'${e.values.first}'")}) 
          AND (level in ${controller.quizController.levelSelected.map((e) => "'${e.values.first}'")})
          GROUP BY word_list.word
          ''',
          controller.quizController.quizWord,
        );
      },
    );
  }
}

class AnswerSetting extends GetView<MainController> {
  const AnswerSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return CDropdown(
      hint: "Jawaban",
      isSingleValue: true,
      value: controller.quizController.answerChoice,
      selectedValue: controller.quizController.answerSelected,
      onChange: () {
        controller.quizController.setQuizWordList(
          controller.databaseController.database!,
          '''
          SELECT level, type, type_name, word_list.*
          FROM word_list
          JOIN word_level ON word_list.word = word_level.word
          JOIN word_type ON word_list.word = word_type.word
          JOIN type_list ON word_type.type_code = type_list.type_code
          WHERE (type in ${controller.quizController.typeSelected.map((e) => "'${e.values.first}'")}) 
          AND (level in ${controller.quizController.levelSelected.map((e) => "'${e.values.first}'")})
          GROUP BY word_list.word
          ''',
          controller.quizController.quizWord,
        );
        controller.quizController.setQuizWordVisibility(false);
      },
    );
  }
}
