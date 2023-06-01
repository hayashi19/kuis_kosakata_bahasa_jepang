// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/custome_button.dart';
import '../../Widgets/custome_textfield.dart';
import '../../main_controller.dart';

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          AnswerField(),
          SizedBox(width: 16),
          AnswerButton(),
        ],
      ),
    );
  }
}

class AnswerField extends GetView<MainController> {
  const AnswerField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => CTextfield(
          onEditingComplete: () => controller.quizController.getNextQuiz(),
          focusNode: controller.quizController.answerFocus.value,
          hintText: controller.quizController.answerSelected.isEmpty
              ? "Jawabnya . . ."
              : "jawab dengan ${controller.quizController.answerSelected.first.values.first} . . .",
          textEditingController:
              controller.quizController.answerController.value,
        ),
      ),
    );
  }
}

class AnswerButton extends GetView<MainController> {
  const AnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton(
      borderColor: Theme.of(context).colorScheme.primary,
      onTap: () => controller.quizController.getNextQuiz(),
      child: Center(
        child: Text(
          "check",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
