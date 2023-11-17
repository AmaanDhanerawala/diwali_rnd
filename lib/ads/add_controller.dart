import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final adsController = ChangeNotifierProvider((ref) => AdsController());

class AdsController extends ChangeNotifier {
  BannerAd? bannerAd;
  AppOpenAd? appOpenAd;
  RewardedAd? rewardedAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  InterstitialAd? interstitialAd;
  InterstitialAd? interstitialAdVideo;

  bool isLoading = false;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';
  final appOpenAdUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/3419835294' : 'ca-app-pub-3940256099942544/5662855259';
  final rewardedAdUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';
  final interstitialAdUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';
  final interstitialAdVideoUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/8691691433' : 'ca-app-pub-3940256099942544/5135589807';
  final rewardedInterstitialAdUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/5354046379' : 'ca-app-pub-3940256099942544/6978759866';

  int rewardAmount = 0;

  updateRewardAmount(int amount) {
    rewardAmount += amount;
    notifyListeners();
  }

////////////////////------------------------Banner Ad--------------------------//////////////
  /// Loads a banner ad.
  void loadBannerAd() {
    isLoading = true;
    notifyListeners();
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoading = false;
          notifyListeners();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  disposeBannerAd() {
    bannerAd = null;
    notifyListeners();
  }

  ////////////////////------------------------App Open Ad--------------------------//////////////
  /// Load an AppOpenAd.
  void loadAppOpenAd() {
    isLoading = true;
    notifyListeners();
    AppOpenAd.load(
      //TODO - Change ID before demo
      adUnitId: 'ca-app-pub-5740266752783813/6945469727',
      // adUnitId: 'ca-app-pub-5740266752783813/6945469721',
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          isLoading = false;
          notifyListeners();
          appOpenAd = ad;
          appOpenAd?.show();
          handleAppOpenFullScreen();
        },
        onAdFailedToLoad: (error) {
          isLoading = false;
          notifyListeners();
          debugPrint('Ad Failed to load --> $error');
        },
      ),
    );
  }

  void showAppOpenAddIfAvailable() {
    if (appOpenAd == null) {
      loadAppOpenAd();
    }
  }

  handleAppOpenFullScreen() {
    appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        appOpenAd = null;
      },
    );
  }

////////////////////------------------------Rewarded Ad--------------------------//////////////
  loadRewardedAd() {
    isLoading = true;
    notifyListeners();
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          isLoading = false;
          notifyListeners();
          rewardedAd = ad;
          rewardedAd?.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              updateRewardAmount(reward.amount.toInt());
            },
          );
          handleRewardedFullScreen();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to Load Ad --> $error');
        },
      ),
    );
  }

  showRewardedAdIfAvailable() {
    if (rewardedAd == null) {
      loadRewardedAd();
    }
  }

  handleRewardedFullScreen() {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        rewardedAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        rewardedAd = null;
      },
    );
  }

////////////////////------------------------Interstitial Ad--------------------------//////////////
  loadInterstitialAd() {
    isLoading = true;
    notifyListeners();
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          isLoading = false;
          notifyListeners();
          interstitialAd = ad;
          interstitialAd?.show();
          handleInterstitialFullScreen();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to Load Ad --> $error');
        },
      ),
    );
  }

  handleInterstitialFullScreen() {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        interstitialAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        interstitialAd = null;
      },
    );
  }

  ////////////////////------------------------Interstitial Video Ad--------------------------//////////////

  loadInterstitialVideoAd() {
    isLoading = true;
    notifyListeners();
    InterstitialAd.load(
      adUnitId: interstitialAdVideoUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          isLoading = false;
          notifyListeners();
          interstitialAdVideo = ad;
          interstitialAdVideo?.show();
          handleInterstitialVideoFullScreen();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to Load Ad --> $error');
        },
      ),
    );
  }

  handleInterstitialVideoFullScreen() {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        interstitialAdVideo = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        interstitialAdVideo = null;
      },
    );
  }

  ////////////////////------------------------Interstitial Reward Video Ad--------------------------//////////////

  loadInterstitialRewardVideoAd() {
    isLoading = true;
    notifyListeners();
    RewardedInterstitialAd.load(
      adUnitId: rewardedInterstitialAdUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          isLoading = false;
          notifyListeners();
          rewardedInterstitialAd = ad;
          rewardedInterstitialAd?.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              //updateRewardAmount(reward.amount.toInt());
            },
          );
          handleInterstitialRewardVideoFullScreen();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to Load Ad --> $error');
        },
      ),
    );
  }

  handleInterstitialRewardVideoFullScreen() {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        interstitialAdVideo = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        interstitialAdVideo = null;
      },
    );
  }
}
