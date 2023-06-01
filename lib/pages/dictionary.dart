import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import files
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/classes/controller.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/pages/home.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const <Widget>[
          SizedBox(height: 24),
          SearchView(),
          SizedBox(height: 8),
          // DictionaryAd1(),
          SizedBox(height: 8),
          Expanded(child: DictionaryList()),
          SizedBox(height: 8),
          // DictionaryAd2()
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return TextField(
      controller: allPageController.txtQuery,
      onChanged: allPageController.searchFIlter,
      decoration: const InputDecoration(
        hintText: "Cari kata kanji, romaji, bahasa",
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}

class DictionaryList extends StatelessWidget {
  const DictionaryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: allPageController.foundWord.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(ListPage(
                altList: allPageController.foundWord, altIndex: index)),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Text(
                      "# ${(index + 1).toString()}",
                      style: const TextStyle(color: Color(0xFFBC002D)),
                    ),
                    const Divider(thickness: 3, color: Color(0xFFBC002D)),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Level ${allPageController.foundWord[index]['Level']}",
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Tipe Kata: ${allPageController.foundWord[index]["WordType"]}",
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    Text(
                      allPageController.foundWord[index]["KanjiCasualPositive"]
                          .toString(),
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      allPageController.foundWord[index]["RomajiCasualPositive"]
                          .toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      allPageController.foundWord[index]["BahasaCasualPositive"]
                          .toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Extra page
class ListPage extends StatelessWidget {
  final List altList;
  final int altIndex;

  const ListPage({Key? key, required this.altList, required this.altIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Halam Penjelasan ${altList[altIndex]["KanjiCasualPositive"]}(${altList[altIndex]["RomajiCasualPositive"]})")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  // For level and word type
                  Text(
                    "Level: ${altList[altIndex]["Level"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tipe Kata: ${altList[altIndex]["WordType"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  // For main dictionary form
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            altList[altIndex]["KanjiCasualPositive"],
                            style: const TextStyle(
                              color: Color(0xFFBC002D),
                              fontSize: 48,
                            ),
                          ),
                          Text(
                            "[ ${altList[altIndex]["RomajiCasualPositive"]} ]",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            altList[altIndex]["BahasaCasualPositive"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    height: 36,
                    thickness: 2,
                  ),
                  // Definition
                  const Text(
                    "Penjelasan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "\t Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(),
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    height: 36,
                    thickness: 2,
                  ),
                  // Casual form
                  const Text(
                    "Konjugasi Kasual (Sehari - hari)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Negatif: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiCasualNegative"]} (${altList[altIndex]["RomajiCasualNegative"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Lampau: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiCasualPast"]} (${altList[altIndex]["RomajiCasualPast"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Negatif Lampau: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiCasualPastNegative"]} (${altList[altIndex]["RomajiCasualPastNegative"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Polite form
                  const Divider(
                    color: Colors.blueGrey,
                    height: 36,
                    thickness: 2,
                  ),
                  const Text(
                    "Konjugasi Sopan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Positif: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiPolitePositive"]} (${altList[altIndex]["RomajiPolitePositive"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Negatif: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiPoliteNegative"]} (${altList[altIndex]["RomajiPoliteNegative"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Lampau: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiPolitePast"]} (${altList[altIndex]["RomajiPolitePast"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Negatif Lampau: "),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${altList[altIndex]["KanjiPolitePastNegative"]} (${altList[altIndex]["RomajiPolitePastNegative"]})"),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ADS(ad: Get.put(AllPageController()).dictionary_banner)
          ],
        ),
      ),
    );
  }
}
