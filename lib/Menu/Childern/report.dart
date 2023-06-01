import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

import '../../Widgets/custome_button.dart';

class Report extends GetView<MainController> {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text("report email"),
          Text("📧"),
        ],
      ),
      onTap: () => controller.menuContoller.report(),
    );
  }
}
