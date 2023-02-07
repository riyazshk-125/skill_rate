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

String appId = "96661";
String authKey = "xJpMGKGQD9EevKu";
String authSecret = "5Oy5vFZzL4gXRDr";
String accountKey = "T8KBZTqUsVHtuUvtKBdz";

// int userId = 0;

/*Future<void> init() async {
  try {
    await QB.settings.init(appId, authKey, authSecret, accountKey);

  } on PlatformException catch (e) {
    Get.log("Main Error : "+e.toString());
  }
}*/

late ApiHolder apiHolder;
late Prefs prefs;

late GlobalController globalController;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late FirebaseHelper firebaseHelper;
// late final NotificationService notificationService;

void main() async {
  // notificationService = NotificationService();
  // notificationService.initializePlatformNotifications();
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  apiHolder = ApiHolder();
  firebaseHelper = FirebaseHelper();
  /*apiHolder.callConstants().then((value) {
    if (value["key"] != null) {
      AppMethods.PAYMENT_MAP = value;
      Get.log("------ ${jsonEncode(AppMethods.PAYMENT_MAP)}");
    }
  });*/
  /*AppMethods.PAYMENT_MAP = {
    "key": "rzp_test_rWa7oEuqI3gS8R",
    "secret": "2Gpl3PkjXX3bxymrLvkwyigm"
  };*/
  prefs = Prefs();

  // const List<String> list = ["icon_1", "icon_2", "icon_3", "MainActivity"];
  // DynamicIconFlutter.setIcon(icon: 'icon_2', listAvailableIcon: list);

  /*FirebaseMessaging.onMessage.listen((event) {
    var map = event.data;
    Get.log(jsonEncode(map));
    sendNotification(map["title"], map["message"], () {
      if (map["type"] == "chat") {
        Get.put<ChatLogic>(ChatLogic()).getSecondTimeChatData();
      }
    });
    if (map["type"] == "chat") {
      Get.put<ChatLogic>(ChatLogic()).getSecondTimeChatData();
    }
    // notificationService.showLocalNotification(id: Random().nextInt(100), title: map["title"], body: map["message"], payload: "");
  });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    var map = event.data;
    Get.log(jsonEncode(map));
    // sendNotification(map["title"], map["message"], () {});
    if (map["type"] == "chat") {
      // Get.to(() => ChatPage());
      Navigator.push(navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => ChatPage()));
    }
  });

  var deviceToken = await messaging.getToken();

  Get.log(deviceToken ?? "");*/
  // await init();

  globalController = Get.put<GlobalController>(GlobalController());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons)
  ));
  runApp(const MyApp());
}
/*

void sendNotification(String title, String body, void Function() onClick) {
  Get.log("Notificvation Show : $title $body");
  NotificationService().showNotifications(
    titleText: title,
    bodyText: body,
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var map = message.data;
  sendNotification(map["title"], map["message"], () {});
  if (map["type"] == "chat") {
    Get.to(() => ChatPage());
  }
}
*/

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
