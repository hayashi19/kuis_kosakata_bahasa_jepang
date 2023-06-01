import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Home/home_page.dart';
import 'main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<MainController>(MainController());
  if (GetPlatform.isDesktop) {
    DesktopWindow.setFullScreen(true);
    DesktopWindow.setMinWindowSize(const Size(720, 720));
  }
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends GetView<MainController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.themeController.isDark.value =
        controller.themeController.loadThemeFromBox();
    return GetMaterialApp(
      title: 'Kuis Kosakata Bahasa Jepang',
      theme: controller.themeController.lightTheme,
      darkTheme: controller.themeController.darkTheme,
      themeMode: controller.themeController.theme,
      home: const SafeArea(child: HomePage()),
    );
  }
}
