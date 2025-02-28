import 'package:beurs/app/app_string.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class InterstitialAdManager {
  final Logger _logger = Logger();
  late InterstitialAd interstitialAd;

  void loadInterstitialAd({required String adUnitId}) {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          _setFullScreenContentCallBack(ad);
        },
        onAdFailedToLoad: (error) {
          _logger.e("Ad failed Load $error");
        },
      ),
    );
  }

  void _setFullScreenContentCallBack(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => _logger.d("$ad Ad on full screen"),
      onAdDismissedFullScreenContent: (ad) {
        _logger.d("$ad Ad Dismissed Load");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _logger.e("$ad Ad Error Load $error");
      },
      onAdImpression: (ad) => _logger.i("$ad Ad Impression "),
    );
    interstitialAd.show();
  }
}
