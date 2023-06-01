import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Dictionary/Childern/dictionary_list.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Dictionary/Childern/search.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: const DictionarySearch(),
        ),
        const SizedBox(height: 32),
        const DictionaryList(),
      ],
    );
  }
}
