import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/custome_container.dart';
import '../../main_controller.dart';

class HomeNavigationBar extends GetView<MainController> {
  const HomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CContainer(
        duration: const Duration(milliseconds: 200),
        borderColor: Theme.of(context).colorScheme.primary,
        isHover: controller.homeController.containerOnTap.value,
        child: BottomNavigationBar(
          //> index on tap
          currentIndex: controller.homeController.pageIndex.value,
          onTap: (newIndex) {
            //?= to change page
            controller.homeController.changePage(newIndex);
            //?= to animate container
            controller.homeController.changeContainerOnTap();
          },
          //> style
          elevation: 0,
          iconSize: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedLabelStyle:
              Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
          unselectedLabelStyle: Theme.of(context).textTheme.bodyText2!,
          unselectedItemColor: Colors.grey,
          //> items
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_rounded),
              label: "kuis",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: "kamus",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: "menu",
            ),
          ],
        ),
      ),
    );
  }
}
