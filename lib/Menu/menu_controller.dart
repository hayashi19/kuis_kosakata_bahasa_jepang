import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Menu/Childern/about_app.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Theme/theme_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuContoller extends GetxController {
  //> rate
  rateApp() async {
    String url =
        'https://play.google.com/store/apps/details?id=com.japanesequiz.user0412';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Error occured sending an email";
    }
  }

  //> about app
  var markdownData = "".obs;
  var markdownController = TextEditingController().obs;
  aboutApp() async {
    markdownData.value = await rootBundle.loadString('assets/About App.md');
    markdownController.value.text = markdownData.value;
    // data.printInfo();
    Get.to(const AboutAppPage());
  }

  //> other version
  otherVersion() async {
    String url = 'https://kuis-kosakata-bahasa-jepang.firebaseapp.com';
    String url2 =
        'https://play.google.com/store/apps/details?id=com.japanesequiz.user0412';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        (GetPlatform.isWeb && GetPlatform.isDesktop) ? url2 : url,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Error occured sending an email";
    }
  }

  downloadDestop() async {
    String url =
        'https://drive.google.com/file/d/1Dn4nMnTNbBoTU0lS-jUR7d3WIluCPAte/view?usp=share_link';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Error occured sending an email";
    }
  }

  //> report
  report() async {
    String email = 'hayashi19t@gmail.com';
    String subject = 'Repost Email Kuis Kosakata B Jepang';
    String body =
        'Tuliskan kesalahan, saran atau keluhan untuk palikasi ini . . .';
    String url = "mailto:$email?subject=$subject&body=$body";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Error occured sending an email";
    }
  }

  //> theme
  changeTheme() => Get.put(ThemeController()).switchTheme();
}
