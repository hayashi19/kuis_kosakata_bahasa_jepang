import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/about_app.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/other_version.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/rate.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/report.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      children: <Widget>[
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          child: const RateMenu(),
        ),
        separator,
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          delay: const Duration(milliseconds: 80),
          child: const AboutApp(),
        ),
        separator,
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          delay: const Duration(milliseconds: 160),
          child: const OtherVersion(),
        ),
        separator,
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          delay: const Duration(milliseconds: 240),
          child: const Report(),
        ),
        separator,
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          delay: const Duration(milliseconds: 320),
          child: const ThemButton(),
        ),
      ],
    );
  }

  Widget get separator => const SizedBox(height: 16);
}
