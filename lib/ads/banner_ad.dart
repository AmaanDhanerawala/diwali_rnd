import 'package:diwali_rnd/ads/add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerExample extends StatelessWidget {
  const BannerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final adsWatch = ref.watch(adsController);
        if (adsWatch.bannerAd != null) {
          return SizedBox(
            width: adsWatch.bannerAd?.size.width.toDouble(),
            height: adsWatch.bannerAd?.size.height.toDouble(),
            child: Stack(
              children: [
                AdWidget(ad: adsWatch.bannerAd!),
                Positioned(
                  right: (adsWatch.bannerAd?.size.width.toDouble() ?? 0) + ((MediaQuery.sizeOf(context).width - (adsWatch.bannerAd?.size.width.toDouble() ?? 0)) / 2) - 10,
                  child: GestureDetector(
                    onTap: () {
                      ref.watch(adsController).disposeBannerAd();
                    },
                    child: const Icon(CupertinoIcons.clear_circled_solid),
                  ),
                ),
              ],
            ),
          );
        }
        return const Offstage();
      },
    );
  }
}
