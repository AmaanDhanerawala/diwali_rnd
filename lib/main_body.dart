import 'package:diwali_rnd/ads/add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBody extends ConsumerWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.money_dollar_circle),
            const SizedBox(width: 10),
            Text('Rewards Points: ${ref.watch(adsController).rewardAmount}'),
          ],
        ),
        const SizedBox(height: 40),
        Wrap(
          children: [
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).showRewardedAdIfAvailable();
                }
              },
              color: Colors.black,
              child: const Text(
                'Get Reward',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).loadBannerAd();
                }
              },
              color: Colors.black,
              child: const Text(
                'Show Banner Ad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).showAppOpenAddIfAvailable();
                }
              },
              color: Colors.black,
              child: const Text(
                'Show Full Screen Ad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).loadInterstitialAd();
                }
              },
              color: Colors.black,
              child: const Text(
                'Show Interstitial Ad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).loadInterstitialVideoAd();
                }
              },
              color: Colors.black,
              child: const Text(
                'Show Interstitial Video Ad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
            MaterialButton(
              onPressed: () {
                if (!kIsWeb) {
                  ref.watch(adsController).loadInterstitialRewardVideoAd();
                }
              },
              color: Colors.black,
              child: const Text(
                'Show Reward Interstitial Ad',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 20, height: 20),
          ],
        )
      ],
    );
  }
}
