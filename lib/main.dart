import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/firebase_helper.dart';
import 'package:skill_rate/screens/splash/splash_main.dart';

import 'firebase_options.dart';
import 'helper/api_helper/apis_holder.dart';
import 'helper/global_controller.dart';
import 'helper/prefs.dart';
import 'helper/theme_data.dart';


late ApiHolder apiHolder;
late Prefs prefs;

late GlobalController globalController;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late FirebaseHelper firebaseHelper;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  apiHolder = ApiHolder();
  firebaseHelper = FirebaseHelper();

  prefs = Prefs();


  globalController = Get.put<GlobalController>(GlobalController());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons)
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skill Rate',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      defaultTransition: Transition.rightToLeftWithFade,
      home: const SplashScreen(),
    );
  }
}
