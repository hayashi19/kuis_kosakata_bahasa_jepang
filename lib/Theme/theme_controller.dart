import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  //> Local assets path
  var correctSound = r"assets/Sound Effect/Correct SE.mp3".obs;
  var correctEmoji = r"assets/Graphics/correct.json".obs;
  var incorrectSound = r"assets/Sound Effect/Incorrect SE.mp3".obs;
  var incorrectEmoji = r"assets/Graphics/inccorect.json".obs;
  var loading = r"assets/Graphics/loading.json".obs;
  var notFound = r"assets/Graphics/not found.json".obs;

  //> Color
  var correctColor = const Color(0xFF8FECC8).obs;
  var incorrectColor = const Color(0xFFFF395E).obs;

  Color primaryColor = const Color(0xFFBE0029);
  Color surface = const Color(0xFF567B97);

  Color lightScaffoldBackgroundColor = const Color(0xFFf8f9fa);
  Color lightSecondary = const Color(0xFF343a40);
  Color lightTertiary = const Color(0xFFda4167);

  Color darkScaffoldBackgroundColor = const Color(0xFF212529);
  Color darkSecondary = const Color(0xFFe9ecef);
  Color darkTertiary = const Color(0xFF7de2d1);

  //> padding
  EdgeInsets defaultPadding(BuildContext context, int padding) =>
      EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + padding,
        top: MediaQuery.of(context).padding.top + padding,
        right: MediaQuery.of(context).padding.right + padding,
        bottom: MediaQuery.of(context).padding.bottom + padding,
      );

  //> theme
  ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: lightScaffoldBackgroundColor,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          primary: primaryColor,
          secondary: lightSecondary,
          tertiary: lightTertiary,
          surface: surface,
        ),
        listTileTheme: const ListTileThemeData(
          dense: true,
          style: ListTileStyle.list,
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(
            color: lightSecondary,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.rampartOne(
            color: lightSecondary,
            fontWeight: FontWeight.bold,
          ),
          button: GoogleFonts.poppins(
            color: lightSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: lightScaffoldBackgroundColor,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: darkScaffoldBackgroundColor,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          primary: primaryColor,
          secondary: darkSecondary,
          tertiary: darkTertiary,
          surface: surface,
        ),
        listTileTheme: const ListTileThemeData(
          dense: true,
          style: ListTileStyle.list,
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(
            color: darkSecondary,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.rampartOne(
            color: darkSecondary,
            fontWeight: FontWeight.bold,
          ),
          button: GoogleFonts.poppins(
            color: darkSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: darkScaffoldBackgroundColor,
        ),
      );

  //> Change theme
  final _box = GetStorage();
  final _key = 'isDarkMode';
  var isDark = false.obs;

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool loadThemeFromBox() => _box.read(_key) ?? false;

  saveThemeToBox(bool isDarkMode) {
    _box.write(_key, isDarkMode);
    isDark.value = isDarkMode;
  }

  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}
