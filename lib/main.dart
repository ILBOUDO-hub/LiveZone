import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/controllers/event_controller.dart';
import 'package:eventpro/controllers/phone_auth_controller.dart';
import 'package:eventpro/controllers/story_controller.dart';
import 'package:eventpro/controllers/ticket_controller.dart';
import 'package:eventpro/firebase_messaging.dart';
import 'package:eventpro/firebase_options.dart';
import 'package:eventpro/models/event.dart';
import 'package:eventpro/ui/event/event_details_screen.dart';
import 'package:eventpro/ui/home/home_screen.dart';
import 'package:eventpro/values/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:pwa_install/pwa_install.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_links/uni_links.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(OtpController());
    Get.put(MyAuthController());
    Get.put(EventController());
    Get.putAsync(() async => TicketController());
    Get.put(StoryController());
  });
  if (!GetPlatform.isWeb) {
    try {
      final uri = await getInitialUri();
      if (uri != null) {
        if (uri.queryParameters['refer'] != null) {
          MyAuthController.instance.referClient(uri.queryParameters['refer']!);
        }
        if (uri.queryParameters['event'] != null) {}
      }
    } on FormatException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
    try {
      await FirebaseMessaging.instance.getInitialMessage();
      FirebaseMessaging.onMessage.listen((event) {
        debugPrint("new message");
        LocalNotificationService.display(event);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  } else {
    // setUrlStrategy(PathUrlStrategy());
  }
  //  PWAInstall().setup(installCallback: () {
  //   debugPrint('APP INSTALLED!');
  // });

  runApp(const EventPro());
  // setUrlStrategy(PathUrlStrategy());
}

class EventPro extends StatelessWidget {
  const EventPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      LocalNotificationService.initialize(context);
    } catch (e) {}

    return FlutterWebFrame(
        maximumSize: Size(475.0, 500), // Maximum size
        enabled: GetPlatform
            .isWeb, // default is enable, when disable content is full size
        backgroundColor: Colors.grey, //
        builder: (context) {
          return GetMaterialApp(
              getPages: [
                GetPage(
                  name: '/',
                  page: () => const HomeScreen(),
                ),
                GetPage(
                  name: '/HomeScreen',
                  page: () => const HomeScreen(),
                ),
                GetPage(
                  name: '/event/:eventName',
                  page: () {
                    try {
                      Event e =
                          EventController.instance.events.where((element) {
                        element as Event;
                        return element.name.trim().toLowerCase() ==
                            Get.parameters['eventName']!.toLowerCase().trim();
                      }).first;
                      return EventDetailsScreen(
                        event: e,
                      );
                    } catch (e) {
                      return const HomeScreen();
                    }
                  },
                ),
              ],
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: const Color.fromARGB(255, 0, 0, 0),
                    rightDotColor: primaryColor,
                    size: 150,
                  ),
                ),
              ),
              // initialRoute: '/HomeScreen',
              builder: EasyLoading.init(),
              theme: ThemeData(
                  primaryColor: primaryColor, backgroundColor: Colors.white));
        });
  }
}
