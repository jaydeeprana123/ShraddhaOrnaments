import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/fcm/firebase.dart';
import 'package:shradha_design/myapp.dart';
import 'package:shradha_design/repositories/app_repository.dart';
import 'package:shradha_design/repositories/prefrance.dart';
import 'package:shradha_design/repositories/repositories.dart';
import 'package:shradha_design/utils/NavigationService.dart';
import 'dart:io';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'appbloc/app_bloc.dart';


/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async{
  /*runApp(MyApp());*/

  WidgetsFlutterBinding.ensureInitialized();
  // implemented using window manager
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  PreferencesHelper pref= PreferencesHelper() ;
  await pref.prefrence();
  final AppRepository appRepository = AppRepository(
      apiClient: ApiClient(dio: Dio(),pref:pref )
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top ,SystemUiOverlay.bottom
      ]);



  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCIUcnaxkemBqjlAmXp8jkYP7tLhJHkf0E",
            appId: "1:723600720142:ios:ae70610ee5dfc72721d75f",
            messagingSenderId: "723600720142",
            projectId: "shraddhaornaments-6ca2b"));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'id', 'channel',
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
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



  runZoned(() {
    runApp(
        MultiBlocProvider(
            providers: [

              BlocProvider<AppBloc>(create: (context) => AppBloc(appRepository:appRepository),),

              // BlocProvider<ShopByBrandBloc>(create: (context) => ShopByBrandBloc(appRepository:appRepository),),

              //BlocProvider<OfferBloc>(create: (context) => OfferBloc(appRepository:appRepository),),

            ],
            child: MaterialApp( navigatorKey: NavigationService.navigatorKey,home: MyApp(),)
        )
    );

  });




}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCIUcnaxkemBqjlAmXp8jkYP7tLhJHkf0E",
            appId: "1:723600720142:ios:ae70610ee5dfc72721d75f",
            messagingSenderId: "723600720142",
            projectId: "shraddhaornaments-6ca2b"));
  } else {
    await Firebase.initializeApp();
  }


  productId = message.data.toString();

  productId =  productId.replaceAll("{product_id: ", "");
  productId = productId.replaceAll("}", "");
  print("message - " + productId + " lhhoijkjl");
  print(' xxxxxxxx cccccccc  Handling a background message ${message.messageId}');


  NotificationHandler.handleNotification(message);

}