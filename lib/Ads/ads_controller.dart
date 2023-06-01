import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController {
  var adsCountDown = 0.obs;
  final BannerAd allBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  final BannerAd dictionaryBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  late InterstitialAd interstitialAd;
  var adIsLoaded = false.obs;

  Future loadInterstitialAd() async {
    if (adIsLoaded.value) {
      await interstitialAd.show();
    }
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
          adIsLoaded.value = true;
          interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            adIsLoaded.value = false;
            interstitialAd.dispose();
            loadInterstitialAd();
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            adIsLoaded.value = false;
            interstitialAd.dispose();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          printError(info: 'InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future loadAds() async {
    await allBanner.load();
    await dictionaryBanner.load();

    await loadInterstitialAd();
    return true;
  }

  disposeAds() {
    allBanner.dispose();
    dictionaryBanner.dispose();
  }
}
