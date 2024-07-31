import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/fcm/firebase.dart';
import 'package:shradha_design/ui/splash/SplashScreen.dart';
import 'package:shradha_design/utils/uidata.dart';

import 'app_theme.dart';
import 'constant/constant.dart';




class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }

}




class MyAppState extends State<MyApp> {


  @override
  void initState() {

    super.initState();



    //initFirebase();

  }


  initFirebase() async{

   // await Firebase.initializeApp();

  }




  @override
  Widget build(BuildContext context) {




    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top ,SystemUiOverlay.bottom
        ]);



 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: AppTheme.primarydark, // status bar color
    ));



    return BlocProvider(
      create: (BuildContext context) => AppBloc(appRepository: BlocProvider.of<AppBloc>(context).appRepository),

      child: MaterialApp(

        title: Constant.AppName,
        theme: ThemeData(
          primaryColor: AppTheme.primary,
          //focusColor: AppTheme.black_800,
         // highlightColor: AppTheme.black_800,
          fontFamily: AppTheme.rubik,
          primarySwatch: Colors.pink,
          //canvasColor: Colors.black,
          backgroundColor: AppTheme.white,
          accentColor: Colors.white,

        //  brightness: Brightness.dark, // or use Brightness.dark
          primaryColorBrightness: Brightness.dark,
          accentColorBrightness: Brightness.light,

          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: AppTheme.primary,
            iconTheme: IconThemeData(
              color: AppTheme.black,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: AppTheme.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeTransitionBuilder(),
            TargetPlatform.android: FadeTransitionBuilder(),
          }),

        ),
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        home: SplashScreen(productId: productId,),
        navigatorObservers: [
       //   FirebaseAnalyticsObserver(analytics: MyApp.analytics),
        ],
        routes: UIData.routes,
        //onGenerateRoute: UIData.onGenerateRoute,


      ),
    );





  }






}
class FadeTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(_, __, animation, ___, child) => FadeTransition(opacity: animation, child: child);
}

