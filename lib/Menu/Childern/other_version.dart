import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

import '../../Widgets/custome_button.dart';

class OtherVersion extends GetView<MainController> {
  const OtherVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("versi lainnya"),
              Text((GetPlatform.isWeb && GetPlatform.isDesktop) ? '📱' : '💻'),
            ],
          ),
          onTap: () => controller.menuContoller.otherVersion(),
        ),
        (GetPlatform.isDesktop && GetPlatform.isWeb)
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  CButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text("download for desktop"),
                        Text("💻"),
                      ],
                    ),
                    onTap: () => controller.menuContoller.downloadDestop(),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
