// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/main_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class QuizScore extends StatelessWidget {
  const QuizScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[CorrectScore(), CorrectText(), IncorrectScore()],
    );
  }
}

class CorrectScore extends GetView<MainController> {
  const CorrectScore({super.key});

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
      shakeAnimationController:
          controller.quizController.correctController.value,
      shakeAnimationType: ShakeAnimationType.SkewShake,
      isForward: false,
      shakeCount: 0,
      shakeRange: 0.2,
      child: CContainer(
        padding: const EdgeInsets.all(10),
        borderColor: controller.themeController.correctColor.value,
        child: Obx(
          () => Text(
            "BENAR ${controller.quizController.correctScore.value}",
            style: TextStyle(
              color: controller.themeController.correctColor.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CorrectText extends GetView<MainController> {
  const CorrectText({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.quizController.correctStatus.value == "BENAR") {
        return CorrectionText(
          lottie: controller.themeController.correctEmoji.value,
          text: "BENAR",
          textColor: controller.themeController.correctColor.value,
        );
      } else if (controller.quizController.correctStatus.value == "SALAH") {
        return CorrectionText(
          lottie: controller.themeController.incorrectEmoji.value,
          text: "SALAH",
          textColor: controller.themeController.incorrectColor.value,
        );
      } else {
        return Container();
      }
    });
  }
}

class CorrectionText extends StatelessWidget {
  String lottie;
  String text;
  Color textColor;
  CorrectionText({
    super.key,
    required this.lottie,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: <Widget>[
          Lottie.asset(
            lottie,
            height: 20,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                  color: textColor,
                )),
          ),
        ],
      ),
    );
  }
}

class IncorrectScore extends GetView<MainController> {
  const IncorrectScore({super.key});

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
      shakeAnimationController:
          controller.quizController.incorrectController.value,
      shakeAnimationType: ShakeAnimationType.SkewShake,
      isForward: false,
      shakeCount: 0,
      shakeRange: 0.2,
      child: CContainer(
        padding: const EdgeInsets.all(10),
        borderColor: controller.themeController.incorrectColor.value,
        child: Obx(
          () => Text(
            "SALAH ${controller.quizController.incorrectScore.value}",
            style: TextStyle(
              color: controller.themeController.incorrectColor.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
