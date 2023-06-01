// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kuis_kosakata_bahasa_jepang_ver_indonesia/Widgets/custome_container.dart';

class BannerAdsContainer extends StatelessWidget {
  BannerAd bannerAd;
  BannerAdsContainer({super.key, required this.bannerAd});

  @override
  Widget build(BuildContext context) {
    return CContainer(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }
}
