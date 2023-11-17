import 'package:diwali_rnd/ads/add_controller.dart';
import 'package:diwali_rnd/ads/banner_ad.dart';
import 'package:diwali_rnd/firebase_options.dart';
import 'package:diwali_rnd/main_body.dart';
import 'package:diwali_rnd/notification/notification_dialog.dart';
import 'package:diwali_rnd/payment/payment_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> getPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  MobileAds.instance.initialize();
  await messaging.requestPermission(alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);
}

void messageListener(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Map<String, dynamic> notificationData = message.data;
    if (notificationData['show_notification'] == 'true') {
      showDialog(
        context: context,
        builder: ((BuildContext context) {
          return NotificationDialog(title: message.notification?.title ?? '', body: notificationData);
        }),
      );
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(' Handling a background message ${message.data}');
  // RemoteNotification? notification = message.notification;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint(await FirebaseMessaging.instance.getToken());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      getPermission().then((value) async {
        messageListener(context);
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Demo"),
          ),
          floatingActionButton: const PaymentButton(),
          body: const MainBody(),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: BannerExample(),
        ),
        ref.watch(adsController).isLoading ? const CircularProgressIndicator() : const Offstage()
      ],
    );
  }
}
