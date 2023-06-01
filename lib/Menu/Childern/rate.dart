import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_button.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

class RateMenu extends GetView<MainController> {
  const RateMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text("beri rating"),
          Text("⭐⭐⭐⭐⭐"),
        ],
      ),
      onTap: () => controller.menuContoller.rateApp(),
    );
  }
}
