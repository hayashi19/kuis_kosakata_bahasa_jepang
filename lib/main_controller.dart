import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Ads/ads_controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Database/database_controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Dictionary/dictionary_controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/menu_controller.dart';

import 'Home/home_controller.dart';
import 'Quiz/quiz_controller.dart';
import 'Theme/theme_controller.dart';

class MainController extends GetxController {
  DatabaseController databaseController = Get.put(DatabaseController());
  ThemeController themeController = Get.put(ThemeController());
  HomeController homeController = Get.put(HomeController());
  QuizController quizController = Get.put(QuizController());
  DictionaryController dictionaryController = Get.put(DictionaryController());
  MenuContoller menuContoller = Get.put(MenuContoller());
  AdsController adsController = Get.put(AdsController());

  //?= for initial login
  var isLoading = true.obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();

    //[] load add
    if (GetPlatform.isAndroid && !GetPlatform.isWeb) adsController.loadAds();

    //[] set the database
    databaseController.createDb().then((database) async {
      //[] set the choices and init value for quiz setting
      // level
      await quizController
          .setQuizSettingChoice(
            database,
            '''SELECT level FROM word_level GROUP BY level''',
            quizController.levelChoice,
          )
          .then(
            (_) => quizController.setQuizSettingValue(
              quizController.levelChoice,
              quizController.levelSelected,
              "N5",
            ),
          );
      // word type
      await quizController
          .setQuizSettingChoice(
            databaseController.database!,
            '''
            SELECT type FROM word_list
            JOIN word_level ON word_list.word = word_level.word
            JOIN word_type ON word_list.word = word_type.word
            JOIN type_list ON word_type.type_code = type_list.type_code
            WHERE level in ${quizController.levelSelected.map((e) => "'${e.values.first}'")}
            GROUP BY type
            ''',
            quizController.typeChoice,
          )
          .then(
            (_) => quizController.setQuizSettingValue(
              quizController.typeChoice,
              quizController.typeSelected,
              "kata kerja",
            ),
          );
      // answer type
      quizController.setQuizSettingValue(
        quizController.answerChoice,
        quizController.answerSelected,
        "Romaji",
      );

      //[] set the quiz word list
      await quizController.setQuizWordList(
        databaseController.database!,
        '''
        SELECT level, type, type_name, word_list.*
        FROM word_list
        JOIN word_level ON word_list.word = word_level.word
        JOIN word_type ON word_list.word = word_type.word
        JOIN type_list ON word_type.type_code = type_list.type_code
        WHERE (type in ${quizController.typeSelected.map((e) => "'${e.values.first}'")}) 
        AND (level in ${quizController.levelSelected.map((e) => "'${e.values.first}'")})
        GROUP BY word_list.word
        ''',
        quizController.quizWord,
      );

      //[] set the dictionary word list
      await dictionaryController.setDictionaryWordList(
        database,
        '''
        SELECT *
        FROM word_list
        JOIN word_level ON word_list.word = word_level.word
        JOIN word_type ON word_list.word = word_type.word
        JOIN type_list ON word_type.type_code = type_list.type_code
        GROUP BY word_list.word
        ORDER BY word_list.word
        ''',
        dictionaryController.dictionaryWord,
      );

      isLoading.value = false;
    });

    //> set text editing

    quizController.answerController.value.addListener(() {});
    dictionaryController.searchController.value.addListener(() {});

    KeyboardVisibilityController().onChange.listen((bool visible) {
      printInfo(info: 'Keyboard visibility update. Is visible: $visible');
      if (!visible) {
        dictionaryController.searchFocuse.value.unfocus();
        quizController.answerFocus.value.unfocus();
      }
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();

    Get.delete();

    if (GetPlatform.isAndroid && !GetPlatform.isWeb) adsController.disposeAds();

    dictionaryController.debounce?.cancel();
    quizController.answerController.value.dispose();
    dictionaryController.searchController.value.dispose();
  }
}
