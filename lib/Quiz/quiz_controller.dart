// ignore_for_file: iterable_contains_unrelated_type

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Theme/theme_controller.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:sqflite/sqlite_api.dart';

class QuizController extends GetxController {
  //> score
  var correctScore = 0.obs;
  var correctController = ShakeAnimationController().obs;
  var correctStatus = "".obs;
  var incorrectScore = 0.obs;
  var incorrectController = ShakeAnimationController().obs;

  //> words
  //?= word list
  var quizWord = <Map>[].obs;
  //?= each word question
  var kanji = <String>[].obs;
  var kanjiV = true.obs;
  var romaji = <String>[].obs;
  var romajiV = false.obs;
  var kana = <String>[].obs;
  var kanaV = false.obs;
  var bahasa = <String>[].obs;
  var bahasaV = true.obs;
  //?= random number
  var ranNum = 0.obs;

  //?= set the quiz word
  Future setQuizWordList(
    Database database,
    String sql, //?: query command
    RxList<Map> list,
  ) async {
    try {
      //[] set temp list for result
      List<Map> result = [];
      //[] query from databse
      await database.rawQuery(sql).then((value) => result = value);
      //[] set the result to the list
      if (result.isNotEmpty) list.value = result;
      //[] call the random number function
      setQuizRandomNumber();
      //[] call quiz word function to set each quiz word
      setQuizWord();
      //[] if contain kana
      List typeList =
          typeSelected.map((element) => element.values.first).toList();
      List levelList =
          levelSelected.map((element) => element.values.first).toList();
      if ((typeList.contains('katakana') || typeList.contains('hiragana')) &&
          !levelList.contains('N5')) {
        Get.snackbar(
          'Kana',
          'huruf kana hanya terdapat pada level N5',
          snackPosition: SnackPosition.BOTTOM,
          barBlur: 0,
          backgroundColor: Colors.white,
        );
      }
      update();
    } catch (e) {
      e.printError();
    }
  }

  //?= get the random number from the lenght of quiz word list
  setQuizRandomNumber() {
    //[] get random number in max number of quiz word list lenght
    ranNum.value = Random().nextInt(quizWord.length);
  }

  //?= split and delete the string base on pattern
  regexSplit(String value, String pattern) => value.split(RegExp(pattern));
  regexDelete(String value, String pattern) =>
      value.replaceAll(RegExp(pattern), "");
  List<String> simplifyString(String value) {
    List<String> temp = List<String>.from(
      regexSplit(
        regexDelete(
          regexDelete(
            regexDelete(
              value,
              r'\(([^)]+)\)|\.',
            ),
            r'\s\s+',
          ),
          r' (-)|(-) | (-) ',
        ),
        r',(?![^(]*\))',
      ),
    );

    List<String> result = [];
    for (var element in temp) {
      result.add(element.toString().trim());
    }
    return result;
  }

  //?= set each quiz word value
  setQuizWord() {
    //[] set kanji
    kanji.value = simplifyString(
      quizWord[ranNum.value]['word'].toString().replaceAll("//", ""),
    );
    //[] set kana, if empty use the word
    kana.value = simplifyString(quizWord[ranNum.value]['reading'].toString());
    //[] set romaji, if empty use the word
    romaji.value = simplifyString(
      quizWord[ranNum.value]['romaji'].toString().trim().toLowerCase(),
    );
    //[] set bahasa
    bahasa.value = simplifyString(
      quizWord[ranNum.value]['bahasa'].toString().toLowerCase(),
    ).toSet().toList();
  }

  //?= check is answer correct or not base on what answer type is being choiced
  bool isAnswerCorrect() {
    try {
      //[] store the answer get from textfield value
      String answer =
          answerController.value.text.toString().trim().toLowerCase();
      //[] check which setting is the answer type is being choosen
      switch (answerSelected.first.values.first.toString()) {
        //[] if kanji compare it to what inside kanji list and kana list
        case "Kanji":
          return kanji.contains(answer) || kana.contains(answer);
        //[] if romaji compare it to what inside romaji
        case "Romaji":
          return romaji.contains(answer);
        //[] if bahasa compare it to what inside bahsa list
        case "Bahasa":
          return bahasa.contains(answer);
        default:
          return false;
      }
    } catch (e) {
      e.printError();
      return false;
    }
  }

  //?= call the sound effect
  Future getSound(String path) async {
    try {
      //[] load the sound assets from path
      ByteData bytes = await rootBundle.load(path);
      //[] convert it to bytes
      Uint8List soundbytes = bytes.buffer.asUint8List(
        bytes.offsetInBytes,
        bytes.lengthInBytes,
      );
      //[] play di audio with byte player
      await AudioPlayer().play(BytesSource(soundbytes));
    } catch (e) {
      e.printError();
    }
  }

  //?= call the shake animation widget
  getShakeAnimation(Rx<ShakeAnimationController> shakeAnimationController) {
    try {
      //[] check if the animation is on play or not
      if (shakeAnimationController.value.animationRunging) {
        shakeAnimationController.value.stop();
      } else {
        shakeAnimationController.value.start(shakeCount: 1);
      }
    } catch (e) {
      e.printError();
    }
  }

  //?= get the next word
  Future getNextQuiz() async {
    try {
      //[] check if the answer status is in correcting state or not
      // if yes do nothing
      if (isCorrecting.value) {
        "Correcting State".printInfo();
      }
      // if not do
      else {
        final ThemeController themeController = Get.put(ThemeController());
        //[] if the answer correct by check the return of answer checking function
        if (isAnswerCorrect()) {
          //[] set the correcting value true
          isCorrecting.value = true;
          //[] play the correct sound
          await getSound(themeController.correctSound.value);
          //[] add the correct score
          correctScore.value++;
          //[] set correct text and its color
          correctStatus.value = "BENAR";
          // correctTextColor.value = const Color(0xFF00EBC7);
          //[] call the shake animation
          getShakeAnimation(correctController);
          //[] delay all the display above for 1 sec
          await Future.delayed(
            const Duration(seconds: 1),
            () {
              //[] set the correct text to normal
              correctStatus.value = "";
              //[] get the random number to generate the next quiz word
              setQuizRandomNumber();
              //[] call quiz word function
              setQuizWord();
              //[] set correcting status
              isCorrecting.value = false;
            },
          );
        } else {
          //[] set correcting status
          isCorrecting.value = true;
          //[] play the incorrect sound
          await getSound(themeController.incorrectSound.value);
          //[] add the incorrect score
          incorrectScore.value++;
          //[] show the correct text
          setVisibility(true, true, true, true);
          //[] set correct text and its color
          correctStatus.value = "SALAH";
          // correctTextColor.value = const Color(0xFFF45D48);
          //[] call the shake animation
          getShakeAnimation(incorrectController);
          //[] delay all the display above for 3 sec
          await Future.delayed(
            const Duration(seconds: 3),
            () {
              //[] set the correct text to normal
              correctStatus.value = "";
              //[] set text visibility to default
              setQuizWordVisibility(true);
              //[] get the random number to generate the next quiz word
              setQuizRandomNumber();
              //[] call quiz word function
              setQuizWord();
              //[] set correcting status
              isCorrecting.value = false;
            },
          );
        }
      }
      answerController.value.clear();
    } catch (e) {
      e.printError();
    }
  }

  //> answer
  var answerController = TextEditingController().obs;
  var answerFocus = FocusNode().obs;
  var isCorrecting = false.obs;

  //> settings
  var showSpell = true.obs;

  var levelChoice = <Map>[].obs;
  var levelSelected = <Map>[].obs;

  var typeChoice = <Map>[].obs;
  var typeSelected = <Map>[].obs;

  var answerChoice = <Map>[
    {"title": "Kanji", "check": false},
    {"title": "Romaji", "check": false},
    {"title": "Bahasa", "check": false},
  ].obs;
  var answerSelected = <Map>[].obs;

  //?= set quiz visibility on some provision
  setVisibility(bool kanji, bool kana, bool romaji, bool bahasa) {
    kanjiV.value = kanji;
    kanaV.value = kana;
    romajiV.value = romaji;
    bahasaV.value = bahasa;
  }

  setQuizWordVisibility(bool isNextWord) {
    try {
      //[] check the current word type if katakana or hiragana
      bool isContainKana = ["katakana", "hiragana"].contains(
        quizWord[ranNum.value]['type'].toString(),
      );
      if (isContainKana && !isNextWord) {
        //[] hide the current word spell if conatain kana
        showSpell.value = isContainKana ? false : true;
        //[] show notification if kana
        Get.snackbar(
          'Kana',
          'huruf kana tidak dapat nampilkan ejaan',
          duration: const Duration(milliseconds: 200),
          animationDuration: const Duration(milliseconds: 200),
          snackPosition: SnackPosition.BOTTOM,
          barBlur: 0,
          backgroundColor: Colors.white,
        );
      }
      //[] change the visibiliti
      switch (answerSelected.first.values.first.toString()) {
        case "Kanji":
          setVisibility(
            false,
            false,
            showSpell.value ? true : false,
            true,
          );
          break;
        case "Romaji":
          setVisibility(
            true,
            false,
            false,
            showSpell.value ? true : false,
          );
          break;
        case "Bahasa":
          setVisibility(
            true,
            showSpell.value ? true : false,
            showSpell.value ? true : false,
            false,
          );
          break;
        default:
          break;
      }
    } catch (e) {
      e.printError();
    }
  }

  //?= set the choice form database base on the level
  Future setQuizSettingChoice(
    Database database,
    String sql, //?: query command
    RxList<Map> list,
  ) async {
    try {
      //[] clear the choice list to prevent duplicate
      list.clear();
      //[] create the temp map variable to store the result
      List<Map> result = [];
      //[] query the data from database
      await database.rawQuery(sql).then((value) => result = value);
      //[] do loop in lenght of the result list to add map contain title or choice and the check value for checkbox
      for (var element in result) {
        //?: the temp map contain title and check value
        Map<String, dynamic> temp = {
          "title": element['${element.keys.first}'],
          "check": false
        };
        //?: add to the list
        list.add(temp);
      }
      //[] update the list
      update();
    } catch (e) {
      e.printError();
    }
  }

  //?= set the init value for quiz settings base on what value is being choosen to be the initial
  setQuizSettingValue(List<Map> value, selectedValue, String initValue) {
    try {
      //[] get the index from the selected initial value
      int index = value.indexWhere((element) => element['title'] == initValue);
      //[] set the check item to true, indicate the item is selected with checbox
      value[index]['check'] = true;
      //[] add to the selected value list
      selectedValue.add(value[index]);
    } catch (e) {
      e.printInfo();
    }
  }
}
