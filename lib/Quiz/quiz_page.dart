import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Quiz/Childern/hint.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Quiz/Childern/settings.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';

import 'Childern/answer.dart';
import 'Childern/score.dart';
import 'Childern/words.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        ListView(
          padding: const EdgeInsets.only(
            right: 4,
            bottom: 4,
          ),
          children: <Widget>[
            FadeInLeft(
              duration: const Duration(milliseconds: 200),
              child: const QuizScore(),
            ),
            separator,
            FadeInLeft(
              duration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 80),
              child: const QuizWords(),
            ),
            separator,
            FadeInLeft(
              duration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 160),
              child: const QuizAnswer(),
            ),
            separator,
            FadeInLeft(
              duration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 240),
              child: const QuizSettings(),
            ),
          ],
        ),
        const HintButton()
      ],
    );
  }

  Widget get separator => const SizedBox(
        height: 32,
      );
}

class QuizPageDesktop extends StatelessWidget {
  const QuizPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        right: 4,
        bottom: 4,
      ),
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: FadeInLeft(
                  child: CContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    child: const QuizSettings(),
                  ),
                ),
              ),
              hSeparator,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FadeInLeft(
                      duration: const Duration(milliseconds: 200),
                      delay: const Duration(milliseconds: 80),
                      child: const QuizScore(),
                    ),
                    separator,
                    FadeInLeft(
                      duration: const Duration(milliseconds: 200),
                      delay: const Duration(milliseconds: 160),
                      child: const QuizWords(),
                    ),
                    separator,
                    FadeInLeft(
                      duration: const Duration(milliseconds: 200),
                      delay: const Duration(milliseconds: 240),
                      child: const QuizAnswer(),
                    ),
                    separator,
                    const HintButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget get separator => const SizedBox(
        height: 32,
      );

  Widget get hSeparator => const SizedBox(
        width: 32,
      );
}
