// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

// Import files
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  final AllPageController allPageController = Get.put(AllPageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeService().theme,
      home: const HomePages(),
    );
  }
}
