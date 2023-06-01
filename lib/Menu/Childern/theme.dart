// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

import '../../Widgets/custome_button.dart';

class ThemButton extends GetView<MainController> {
  const ThemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text("tema"),
          separator,
          ClipRect(
            child: Obx(
              () => Text(
                controller.themeController.isDark.value ? "日" : "月",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .merge(const TextStyle(
                      height: 1,
                      color: Colors.amber,
                      fontSize: 124,
                    )),
              ),
            ),
          ),
          separator,
          Obx(
            () => Text(
              controller.themeController.isDark.value ? "☀️ライトテーム" : "🌙ダークテーム",
            ),
          ),
        ],
      ),
      onTap: () {
        controller.menuContoller.changeTheme();
      },
    );
  }

  Widget get separator => const SizedBox(height: 16);
}
