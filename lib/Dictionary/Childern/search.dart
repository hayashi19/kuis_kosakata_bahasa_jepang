import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_textfield.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

class DictionarySearch extends GetView<MainController> {
  const DictionarySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return CTextfield(
      margin: const EdgeInsets.only(
        right: 4,
        bottom: 4,
      ),
      textEditingController:
          controller.dictionaryController.searchController.value,
      focusNode: controller.dictionaryController.searchFocuse.value,
      hintText: "Cari kata dalam kanji, kana, romaji, atau bahasa",
      onEditingComplete: () => Get.back(),
      onSubmitted: (value) => Get.back(),
      onChange: (value) async {
        await controller.dictionaryController.searchFilter(
          controller.databaseController.database!,
          '''
        SELECT *
        FROM word_list
        JOIN word_level ON word_list.word = word_level.word
        JOIN word_type ON word_list.word = word_type.word
        JOIN type_list ON word_type.type_code = type_list.type_code
        WHERE word_list.word LIKE '%$value%'
        OR word_list.reading LIKE '%$value%'
        OR word_list.romaji LIKE '%$value%'
        OR word_list.bahasa LIKE '%$value%'
        GROUP BY word_list.word
        ORDER BY word_list.word
        ''',
          value,
        );
      },
    );
  }
}
