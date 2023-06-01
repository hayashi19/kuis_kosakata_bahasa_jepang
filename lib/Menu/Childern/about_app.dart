import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_button.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';

class AboutApp extends GetView<MainController> {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text("tentang aplikasi"),
          Text("📇"),
        ],
      ),
      onTap: () async => await controller.menuContoller.aboutApp(),
    );
  }
}

class AboutAppPage extends GetView<MainController> {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).padding.left + 32,
          top: MediaQuery.of(context).padding.top + 16,
          bottom: MediaQuery.of(context).padding.bottom + 32,
          right: MediaQuery.of(context).padding.right + 32,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Markdown(
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  h2: Theme.of(context).textTheme.bodyText2,
                  h3: Theme.of(context).textTheme.bodyText2,
                  blockquoteDecoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.secondary.withAlpha(100),
                  ),
                ),
                data: controller.menuContoller.markdownData.value,
              ),
              // ),
            ),
            const SizedBox(height: 32),
            const BackButton()
          ],
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      child: const Center(child: Text("kembali")),
      onTap: () => Get.back(),
    );
  }
}
