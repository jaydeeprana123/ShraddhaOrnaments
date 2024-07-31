import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info/package_info.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/fcm/firebase.dart';
import 'package:shradha_design/repositories/prefrance.dart';
import 'package:shradha_design/response/common/common_response.dart';
import 'package:shradha_design/ui/login/Login.dart';
import 'package:shradha_design/ui/login/PassCode.dart';
import 'package:shradha_design/ui/splash/SplashBloc.dart';
import 'package:shradha_design/utils/BuildConfigData.dart';
import 'package:shradha_design/utils/deviceinfo.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_theme.dart';
import '../../utils/NavigationService.dart';
import '../../utils/my_icons.dart';
import '../widget/snack.dart';

class SplashScreen extends StatefulWidget {

  final String productId;

   SplashScreen({Key key, this.productId}) : super(key: key);


  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {

  String finalProductId;

  SplashBloc _bloc;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  // String _currentAddress;
  // Position _currentPosition;
  //
  // String isLocationShowInRajkot = "0";
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  @override
  void initState() {

    finalProductId = widget.productId;
    initAllMethods();

    super.initState();




  }


  initAllMethods() async{
    _bloc = SplashBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    print("xxxxxxx  islive::" + NetworkContastant.isLive.toString());
    await setupInteractedMessage();
    getName();

    init();
    NotificationHandler().notConfig();

    fcmTopic();
    setup();
  }

  init() async {
    DeviceInfo().isIpad(context);

    PreferencesHelper pref = PreferencesHelper();

    await pref.prefrence();

    // await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (pref.getFCMToken() == "") {
      pref.setFcmTocken(await fcm.getToken());
    }

    CommonResponse response = await _bloc.getcontact(false);

    bool validatecheck = await validate(response);

    if (validatecheck) {
      Timer(Duration(seconds: 3), () {
        if (pref.isLogged()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PasscodeScreen(productId: finalProductId)),
          );
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
        }
      });
    } else {
      _showVersionDialog(true);
    }
  }

  Future<bool> validate(CommonResponse response) async {
    PackageInfo info = await BuildConfigData().getAppData();

    if (response != null && response.data != null) {
      int versionresponse = int.parse(response.data.android_version.toString());
      int iosversionresponse = int.parse(response.data.ios_version.toString());

      //int versionresponse = 27;
      //int iosversionresponse = 7;

      print("versionresponse - " + versionresponse.toString());
      print("iosversionresponse" + iosversionresponse.toString());
      if (Platform.isAndroid && versionresponse > int.parse(info.buildNumber)) {
        return false;
      } else if (Platform.isIOS &&
          iosversionresponse > int.parse(info.buildNumber)) {
        return false;
      } else {
        return true;
      }
    }

    return true;
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }





  void _handleMessage(RemoteMessage message) {
    print("onMessage RemoteMessage data: $message");
    //
    // if(message.data.isNotEmpty){
    //   finalProductId = message.data.toString();
    //   finalProductId =  productId.replaceAll("{product_id: ", "");
    //   finalProductId = productId.replaceAll("}", "");
    //
    //   _showInSnackBar(finalProductId);
    //
    //   print("message - " + finalProductId + " lhhoijkjl");
    //
    // }



    // print("payload productId - " +  productId);
    //
    // if(finalProductId.isNotEmpty){
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Container(
        color: AppTheme.bg,
        child: Scaffold(
            backgroundColor: AppTheme.background,
            body: Stack(
              children: [
                (_bloc.apiProvider.pref.getsplceImage() != "")
                    ? CachedNetworkImage(
                        imageUrl: _bloc.apiProvider.pref.getsplceImage(),
                        fit: BoxFit.fill,
                        height: height,
                        width: width,
                        errorWidget: (context, url, error) => Image.asset(
                          bg,
                          fit: BoxFit.fill,
                          height: height,
                          width: width,
                        ),
                        //placeholder: (context, url) => Image.asset('assets/images/bg.gif',height: 80,),
                      )
                    : Image.asset(
                        bg,
                        fit: BoxFit.fill,
                        height: height,
                        width: width,
                      ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (_bloc.apiProvider.pref.getsplceImage() == "")
                        ? Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: _bloc.apiProvider.pref.getsplacelogo(),
                                fit: BoxFit.contain,
                                height: 160,
                                errorWidget: (context, url, error) => Image.asset(
                                  logo_home,
                                  height: 160,
                                ),
                                //placeholder: (context, url) => Image.asset('assets/images/bg.gif',height: 80,),
                              ),

                              /*Image.asset('assets/images/logo.png',fit: BoxFit.fitHeight,height:  60),*/
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            )

            /*Container(

            decoration: BoxDecoration(

             */ /* image: DecorationImage(
                image: (_bloc.apiProvider.pref.getsplceImage()!="")?C AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.fill,

              ),*/ /*

              image: DecorationImage(
                image: CachedNetworkImage(imageUrl:,fit: BoxFit.contain,height: 80,
                  errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: 80,),
                  placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 80,),
                ),
                fit: BoxFit.fill,

              ),

            ),


            child:

          ),*/
            ),
      ),
    );
  }

  getName() {
    if (Constant.versionName == "") {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        //String appName = packageInfo.appName;
        Constant.versionName = packageInfo.version;

        print("xxxxxxxx version::" + packageInfo.buildNumber);
        print("xxxxxxxx version::" + packageInfo.version);
        // String version = packageInfo.version;
        //String buildNumber = packageInfo.buildNumber;
      });
    }
  }

  @override
  void dispose() {
    LogCustom.logd("xxxxxxx dispose");

    PaintingBinding.instance.imageCache.clear();

    super.dispose();
  }

  // ignore: non_constant_identifier_names
  final String APP_STORE_URL = 'https://apps.apple.com/us/app/id1592640058';

  // ignore: non_constant_identifier_names
  final String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.bytesbee.shraddha.activities';

  Future _showVersionDialog(bool isrequired) async {
    LogCustom.logd("xxxxxxxxxxxxxxx new dialog open _showVersionDialog");

    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "\n There is a newer version of app available please update it now.";
        return new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: getButton(isrequired),
        );
      },
    );
  }

  List<Widget> getButton(bool isrequire) {
    String btnLabel = "Update Now";
    // String btnLabelCancel = "Later";

    List<Widget> listview = [];

    listview.add(TextButton(
        child: Text(
          btnLabel,
          style: TextStyle(color: AppTheme.green),
        ),
        onPressed: () {
          Navigator.pop(context);

          _launchURL();
        }));

    return listview;
  }

  _launchURL() async {
    String url = "";

    if (Platform.isIOS) {
      url = APP_STORE_URL;
    } else {
      url = PLAY_STORE_URL;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
