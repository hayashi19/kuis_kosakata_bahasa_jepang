import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////// THEME
class AppTheme {
  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFBC002D),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF1D1E2C),
        foregroundColor: Color(0xFFACE8DD),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF3B1C32),
          backgroundColor: Color(0xFFBC002D)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFFBC002D),
              onPrimary: Colors.white,
              shadowColor: Colors.redAccent[400],
              textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: const Color(0xFFBC002D),
      )),
      appBarTheme: const AppBarTheme(
          color: Color(0xFFBC002D),
          titleTextStyle: TextStyle(color: Colors.white)),
      cardTheme: CardTheme(
          color: Colors.grey[50], elevation: 4, shadowColor: Colors.black),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ));

  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFBC002D), //const Color(0xFF55192A),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFACE8DD),
        foregroundColor: Color(0xFF1D1E2C),
      ),
      scaffoldBackgroundColor: const Color(0xFF1D1E2C),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Color(0xFFFEE4B6),
        backgroundColor: Color(0xFFBC002D), //Color(0xFF55192A),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFFBC002D), //const Color(0xFF55192A),
              onPrimary: Colors.white,
              shadowColor: const Color(0xFFBC002D),
              textStyle: const TextStyle(fontWeight: FontWeight.bold))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: const Color(0xFFACE8DD),
      )),
      appBarTheme: const AppBarTheme(
          color: Color(0xFFBC002D), //Color(0xFF55192A),
          titleTextStyle: TextStyle(color: Colors.white)),
      cardTheme: CardTheme(
          color: Colors.blueGrey[900],
          elevation: 4,
          shadowColor: Colors.grey[900]),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF1D1E2C),
      ));
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// THEME

class AllPageController extends GetxController {
  // QUIZ ////////////////////////////////////////////////////////////////////////////////////////////////
  // SCORE SECTION
  var trueScore = 0.obs;
  var falseScore = 0.obs;
  var falseOrTrue = "".obs;
  var falseOrTrueColor = (Colors.lightGreen).obs;

  // QUESTION SECTION
  var kanjiVisibility = true.obs;
  var romajiVisibility = false.obs;
  var bahasaVisibility = true.obs;
  var quizWordList = [].obs;
  var rand = 0.obs;

  // SETTING SECTION
  final answerTypeItem = ['Kanji', 'Romaji', 'Bahasa'].obs;
  var answerTypeValue = "Romaji".obs;
  final wordTypeItem = ["Kata Kerja", "Kata Sifat", "Kata Benda"].obs;
  var wordTypeValue = "Kata Kerja".obs;
  final levelTypeItem = ["N5", "N4"].obs;
  var levelTypeValue = "N5".obs;

  var spellingVisibility = false.obs;

  // TEXTFIELD SECTION
  TextEditingController submitTextfield = TextEditingController();

  randNum() => rand.value = Random().nextInt(quizWordList.length);

  void changeSpellingVisibility(value) {
    spellingVisibility.value = value;
    answerTypeValue.value.contains("Romaji")
        ? bahasaVisibility.value = !value
        : answerTypeValue.value.contains("Kanji")
            ? romajiVisibility.value = !value
            : romajiVisibility.value = !value;
  }

  // function to check which the wordtype is being used by user
  void changeWordType(wordType, levelType) async {
    final dir = await getApplicationDocumentsDirectory();
    switch (wordType) {
      case "Kata Kerja":
        final fileVerb = File('${dir.path}/verb.json');
        quizWordList.value = jsonDecode(fileVerb.readAsStringSync())[levelType];
        randNum();
        break;
      case "Kata Sifat":
        final fileAdjective = File('${dir.path}/adjective.json');
        quizWordList.value =
            jsonDecode(fileAdjective.readAsStringSync())[levelType];
        randNum();
        break;
      case "Kata Benda":
        final fileNoun = File('${dir.path}/noun.json');
        quizWordList.value = jsonDecode(fileNoun.readAsStringSync())[levelType];
        randNum();
        break;
      default:
    }
  }

  // set the visibility function to visibilty change base on answer type
  wordVisibility(answerType) {
    switch (answerType) {
      case "Kanji":
        if (spellingVisibility.isTrue) {
          bahasaVisibility.value = true;
          romajiVisibility.value = kanjiVisibility.value = false;
          return;
        }
        romajiVisibility.value = bahasaVisibility.value = true;
        kanjiVisibility.value = false;
        break;
      case "Romaji":
        if (spellingVisibility.isTrue) {
          kanjiVisibility.value = true;
          bahasaVisibility.value = romajiVisibility.value = false;
          return;
        }
        kanjiVisibility.value = bahasaVisibility.value = true;
        romajiVisibility.value = false;
        break;
      case "Bahasa":
        if (spellingVisibility.isTrue) {
          kanjiVisibility.value = true;
          bahasaVisibility.value = romajiVisibility.value = false;
          return;
        }
        kanjiVisibility.value = romajiVisibility.value = true;
        bahasaVisibility.value = false;
        break;
      default:
    }
  }

  // if answer false
  answerFalse(answerType) {
    falseScore.value++;
    kanjiVisibility.value =
        romajiVisibility.value = bahasaVisibility.value = true;
    falseOrTrue.value = "SALAH";
    falseOrTrueColor.value = Colors.red;
    submitTextfield.clear();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        wordVisibility(answerType);
        falseOrTrue.value = "";
        randNum();
      },
    );
  }

  // if answer true
  answerTrue() {
    randNum();
    trueScore.value++;
    submitTextfield.clear();
    falseOrTrue.value = "BENAR";
    falseOrTrueColor.value = Colors.green;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        falseOrTrue.value = "";
      },
    );
  }

  // function for checking the answer
  void checkAnswer(answerType) {
    // check which answer tyle that user use, than execute the function if answer base on answer type is same as the question
    switch (answerType) {
      case "Kanji":
        if (submitTextfield.text
            .contains(quizWordList[rand.value]["KanjiCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      case "Romaji":
        if (submitTextfield.text
            .contains(quizWordList[rand.value]["RomajiCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      case "Bahasa":
        if (submitTextfield.text
            .contains(quizWordList[rand.value]["BahasaCasualPositive"])) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      default:
    }
  }
  // QUIZ ////////////////////////////////////////////////////////////////////////////////////////////////

  // DICTIONARY ////////////////////////////////////////////////////////////////////////////////////////////////
  var dictionaryWordList = [].obs;
  var foundWord = [].obs;

  // Textfield controler for search word in list dictionary
  TextEditingController txtQuery = TextEditingController();

  // function to initialize words to dictionary list from the downloaded file from firebase
  Future getList() async {
    final dir = await getApplicationDocumentsDirectory();
    final fileVerb = File('${dir.path}/verb.json');
    final fileAdjective = File('${dir.path}/adjective.json');
    final fileNoun = File('${dir.path}/noun.json');

    if (fileVerb.existsSync() ||
        fileAdjective.existsSync() ||
        fileAdjective.existsSync()) {
      dictionaryWordList.value = jsonDecode(fileVerb.readAsStringSync())['N5'] +
          jsonDecode(fileVerb.readAsStringSync())['N4'] +
          jsonDecode(fileAdjective.readAsStringSync())['N5'] +
          jsonDecode(fileAdjective.readAsStringSync())['N4'] +
          jsonDecode(fileNoun.readAsStringSync())['N5'] +
          jsonDecode(fileNoun.readAsStringSync())['N4'];

      foundWord.value = dictionaryWordList;
      foundWord.sort(
        (a, b) => a['KanjiCasualPositive'].toLowerCase().compareTo(
              b['KanjiCasualPositive'].toLowerCase(),
            ),
      );

      quizWordList.value = jsonDecode(fileVerb.readAsStringSync())['N5'];
      rand.value = Random().nextInt(quizWordList.length);
    } else {
      downloadAndUpdateWord();
    }
  }

  // This function is called whenever the text field changes
  void searchFIlter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = dictionaryWordList;
    } else {
      results = dictionaryWordList.where((words) {
        final kanji = words["KanjiCasualPositive"].toLowerCase();
        final romaji = words["RomajiCasualPositive"].toLowerCase();
        final bahasa = words["BahasaCasualPositive"].toLowerCase();
        final searchLower = enteredKeyword.toLowerCase();

        return kanji.contains(searchLower) ||
            romaji.contains(searchLower) ||
            bahasa.contains(searchLower);
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundWord.value = results;
  }
  // DICTIONARY ////////////////////////////////////////////////////////////////////////////////////////////////

  // SETTING ////////////////////////////////////////////////////////////////////////////////////////////////
  // Set function to save word list verb, adjective and noun to be downloaded to local app directory
  Future downloadAndUpdateWord() async {
    final dir = await getApplicationDocumentsDirectory();

    // 1) set the reference form firebase storage file location
    Reference refVerb = FirebaseStorage.instance.ref('/word_list/verb.json');
    Reference refAdjective =
        FirebaseStorage.instance.ref('/word_list/adjective.json');
    Reference refNoun = FirebaseStorage.instance.ref('/word_list/noun.json');

    // 2) set the local file path
    final fileVerb = File('${dir.path}/${refVerb.name}');
    final fileAdjective = File('${dir.path}/${refAdjective.name}');
    final fileNoun = File('${dir.path}/${refNoun.name}');

    // 3) write the firebase reference to local file path that has been defined
    await refVerb.writeToFile(fileVerb);
    await refAdjective.writeToFile(fileAdjective);
    await refNoun.writeToFile(fileNoun);

    Get.snackbar("Download Dan Update",
        "${refVerb.name}, ${refAdjective.name}, ${refNoun.name} telah diunduh. List telah diperbarui.");

    print("DONWLOAD DOWNLOAD DOWNLOAD DOWNLOAD");
    getList();
  }

  var aboutApp =
      "Aplikasi ini tidak menyediakan sertifikat apapun tentang bahasa Jepang, seperti JPLT atau semancamnya.\nAplikasi ini dibuat bertujuan agar pengguna bisa belajar dan menghafal kosakata-kosakata bahasa Jepang. Aplikasi ini juga bertujuan agar pengguna dapat menghafal setiap kanji, cara pengucapan dan arti dari kata tersebut dalam bahasa Indonesia. Aplikasi ini dibuat berdasarkan kosakata JPLT. Tetapi tidak menjamin kalau penerjemahan dan pelafalan kosakatanya tepat 100%. Jika ada kesalahan kanji, translasi, atau ada saran bisa hub email developer atau lewat review google playstore. Terima kasih telah mengunduh aplikasi ini."
          .obs;
  var rateLink =
      'https://play.google.com/store/apps/details?id=com.japanesequiz.user0412&hl=en&gl=US'
          .obs;
  var websiteVersion = 'https://kuis-kosakata-bahasa-jepang.web.app/'.obs;

  // theme button variable
  var themeButtonColor = (Colors.black).obs;
  var themeButtonTextColor = (Colors.white).obs;
  var themeButtonText = "Tema Gelap".obs;
  var themeButtonIcon = const Icon(Icons.brightness_2);

  void changeButtonTheme() {
    if (Get.isDarkMode) {
      themeButtonColor.value = Colors.black;
      themeButtonTextColor.value = Colors.white;
      themeButtonText = "Tema Gelap".obs;
      themeButtonIcon = const Icon(Icons.brightness_2);
      return;
    } else {
      themeButtonColor.value = Colors.white;
      themeButtonTextColor.value = Colors.black;
      themeButtonText = "Tema Terang".obs;
      themeButtonIcon = const Icon(Icons.brightness_7_outlined);
    }
  }
  // SETTING ////////////////////////////////////////////////////////////////////////////////////////////////

// ADS ////////////////////////////////////////////////////////////////////////////////////////////////
  var adsCountDown = 0.obs;
  final BannerAd allBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  final BannerAd dictionary_banner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  late InterstitialAd interstitialAd;
  var adIsLoaded = false.obs;

  void loadInterstitialAd() async {
    if (adIsLoaded.value) {
      await interstitialAd.show();
    }
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
          adIsLoaded.value = true;
          print("ADS LOADED ADS LOADED ADS LOADED ADS LOADED ADS LOADED");

          interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            adIsLoaded.value = false;
            interstitialAd.dispose();
            loadInterstitialAd();
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            adIsLoaded.value = false;
            interstitialAd.dispose();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
  // ADS ////////////////////////////////////////////////////////////////////////////////////////////////

  var currentIndex = 0.obs;
  late PageController pageViewController;

  changeIndex(index) => currentIndex.value = index;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    pageViewController = PageController(initialPage: currentIndex.value);
    getList();

    allBanner.load();
    dictionary_banner.load();

    loadInterstitialAd();
  }
}
