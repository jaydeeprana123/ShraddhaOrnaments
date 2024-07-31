import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shradha_design/ui/splash/SplashScreen.dart';

import '../main.dart';
import '../ui/widget/snack.dart';
import '../utils/NavigationService.dart';
import '../utils/page_transition.dart';





final FirebaseMessaging fcm = FirebaseMessaging.instance;

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
String productId = "";

// BuildContext context;



fcmTopic(){

 // context = mContext;

  if(Platform.isIOS){

      fcm.subscribeToTopic("ios_all");

  }else{

      fcm.subscribeToTopic("android_all");

  }


}



setup() async{

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage message) {
    if (message != null) {


      if(message.data.isNotEmpty){

        String productId = "";

        productId = message.data.toString();

        productId =  productId.replaceAll("{product_id: ", "");
        productId = productId.replaceAll("}", "");
        print("message - " + productId + " lhhoijkjl");
        debugPrint(" xxxxxxxxx onMessageOpenedApp ccccc:   $message");

        if(productId.isNotEmpty){

          Navigator?.push(
              NavigationService.navigatorKey.currentContext,
              MaterialPageRoute(
                  builder: (context) => SplashScreen(
                    productId:  productId,
                  )));

          print("productId..." + productId);
        }

      }


     /* Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));*/
    }
  });



  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   // RemoteNotification notification = message.notification;
   // AndroidNotification android = message.notification?.android;

    debugPrint(" xxxxxxxxx onMessage ccccc:   $message");
    debugPrint(" xxxxxxxxx onMessage ccccc:   "+message.notification.title);

    NotificationHandler.handleNotification(message);


  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

    productId = message.data.toString();

    productId =  productId.replaceAll("{product_id: ", "");
    productId = productId.replaceAll("}", "");
    print("message - " + productId + " lhhoijkjl");
    debugPrint(" xxxxxxxxx onMessageOpenedApp ccccc:   $message");


    NotificationHandler.handleNotification(message);



   /* Navigator.pushNamed(context, '/message',
        arguments: MessageArguments(message, true));*/
  });





    // Or do other work.
  }




  class NotificationHandler {


  static final NotificationHandler _singleton = NotificationHandler._internal();


  factory NotificationHandler() {
    // factory constructordan geriye deger return etmek için kullanılı
    return _singleton;
  }

  NotificationHandler._internal();

  notConfig()async{
    notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();


    var initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {

          debugPrint('xxxxxxxx  notification payload: onDidReceiveLocalNotification ' + payload);

        });

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,

        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('xxxxxxxx notification hahaha payload: ' + payload.toString());

            // if(payload=="offer"){
            //  // PageTransition.createRoutedata(context,"OfferFragment",null);
            //
            // }



            //

            print("payload productId - " +  productId);

            if(productId.isNotEmpty){

              Navigator?.push(
                  NavigationService.navigatorKey.currentContext,
                  MaterialPageRoute(
                      builder: (context) => SplashScreen(
                        productId:  productId,
                      )));

              print("productId..." + productId);
            }





          }
          //selectNotificationSubject.add(payload);
        });



  }



  static Future<void> handleNotification (RemoteMessage message) async {
    print("onMessage RemoteMessage data: $message");
      productId = message.data.toString();

    productId =  productId.replaceAll("{product_id: ", "");
    productId = productId.replaceAll("}", "");
    print("message - " + productId + " lhhoijkjl");
    //
    // print("payload productId - " +  productId);
    //
    // if(productId.isNotEmpty){
    //
    //   Navigator.push(
    //       NavigationService.navigatorKey.currentContext,
    //       MaterialPageRoute(
    //           builder: (context) => SplashScreen(
    //             productId:  productId,
    //           )));
    //
    //   print("productId..." + productId);
    // }



    NotificationHandler.showNotificationtext(message.notification);




  }


  //
  // request
  //
  // aadhar card, paan card, online cibil


 static void showNotificationtext(RemoteNotification message) async {


    debugPrint("xxxxxxxxxx title call:");

   // debugPrint("xxxxxxxxxx title:"+message.containsKey("data").toString());
    //debugPrint("xxxxxxxxxx data:"+message['data'].toString());
    debugPrint("xxxxxxxxxx data:title :"+message.title);

    String title=message.title;

    String textMassge=message.body;
    String titleLocKey=message.titleLocKey;
    String body=message.body;



    debugPrint("xxxxxxxxxx title title:"+title);
    debugPrint("xxxxxxxxxx title body:"+textMassge);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id', 'channel',
        importance: Importance.max,
        priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        1, title, textMassge, platformChannelSpecifics,
        payload: title);


   // debugPrint("xxxxxxxxxx title imageBanner:"+message['imageBanner'].toString());



  }





}











