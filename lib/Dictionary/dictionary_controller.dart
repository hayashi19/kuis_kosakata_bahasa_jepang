// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:url_launcher/url_launcher_string.dart';

class DictionaryController extends GetxController {
  //> word list
  var dictionaryWord = [].obs;
  var foundWord = [].obs;

  Future setDictionaryWordList(
    Database database,
    String sql, //?: query command
    RxList list,
  ) async {
    try {
      //[] set temp list for result
      List<Map<String, Object?>> result = [];
      //[] query from databse
      await database.rawQuery(sql).then((value) => result = value);
      //[] set the result to the list
      dictionaryWord.value = result;
      foundWord.value = list;
      update();
    } catch (e) {
      e.printError();
    }
  }

  //?= split and delete the string base on pattern
  regexSplit(String value, String pattern) => value.split(RegExp(pattern));
  regexDelete(String value, String pattern) =>
      value.replaceAll(RegExp(pattern), "");
  List<String> bahasaString(String value) {
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

  //> word list detail
  // kana
  Future<List> type(Database database, String word) async {
    List<Map<String, Object?>> result = [];
    String sql = '''
    SELECT type_name
    FROM word_list
    JOIN word_type ON word_list.word = word_type.word
    JOIN type_list ON word_type.type_code = type_list.type_code
    WHERE word_list.word = '$word'
    ''';
    await database.rawQuery(sql).then((value) {
      result = value;
    });
    return result;
  }

  List getKana(int index) => regexSplit(
        foundWord[index]['reading'].toString(),
        r',(?![^(]*\))',
      );
  // kanji
  List getKanji(int index) => regexSplit(
        foundWord[index]['word'].toString(),
        r',(?![^(]*\))',
      );
  // romaji
  List getRomaji(int index) => regexSplit(
        foundWord[index]['romaji'].toString(),
        r',(?![^(]*\))',
      );
  // bahasa
  List getBahasa(int index) => regexSplit(
        foundWord[index]['bahasa'].toString(),
        r',(?![^(]*\))',
      );

  //> search text
  var searchController = TextEditingController().obs;
  var searchFocuse = FocusNode().obs;
  Timer? debounce;
  var lastInputValue = "".obs;
  // This function is called whenever the text field changes
  Future searchFilter(
    Database database,
    String sql,
    String searchValue,
  ) async {
    try {
      if (lastInputValue != searchValue) {
        lastInputValue.value = searchValue;
        if (debounce?.isActive ?? false) {
          debounce!.cancel();
          update();
        }
        debounce = Timer(const Duration(milliseconds: 800), () async {
          List<Map<String, Object?>> results = [];
          results = searchValue.isEmpty
              ? List<Map<String, Object?>>.from(dictionaryWord)
              : await database.rawQuery(sql);
          foundWord.value = results;
        });
        update();
      }
    } catch (e) {
      e.printError();
      rethrow;
    }
  }

  //> translation Word/phrase scraping
  var translatedWord = RxMap();
  bool wordExist() => translatedWord['found'] == true;
  String wordUri() => wordExist() ? translatedWord['data']['uri'] : "";
  List wordTags() => wordExist() ? translatedWord['data']['tags'] : [];
  List wordMeaning() => wordExist() ? translatedWord['data']['meanings'] : [];
  List wordOtherForms() =>
      wordExist() ? translatedWord['data']['otherForms'] : [];
  List wordAudio() => wordExist() ? translatedWord['data']['audio'] : [];
  Future<Map> getTranslation(int index) async {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('');
      String result = "";
      await jisho
          .scrapeForPhrase(
              getKanji(index).first.toString().replaceAll('//', ""))
          .then(
            (value) => result = encoder.convert(value),
          );
      translatedWord.value = jsonDecode(result);
      return translatedWord;
    } catch (e) {
      e.printError();
      rethrow;
    }
  }

  //> open link
  launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //> plau sound from url
  audioUrl(String url) async {
    final player = AudioPlayer();
    await player.play(UrlSource(url));
  }
}
