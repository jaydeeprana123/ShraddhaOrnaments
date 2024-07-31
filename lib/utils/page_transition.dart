import 'package:flutter/cupertino.dart';

class PageTransition{


static Route createRoute(BuildContext  context, Widget widget, String  name) {
 
 
 
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
   settings: RouteSettings(name:'/'+name ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),

        child: child,
      );
    },
  );


}







 static  createRoutedata(BuildContext  context,  String  name ,Object data) {

  if(data!=null){

   // LogCustom.logd("xxxxxxxx trnsiction:::"+data.toString());

    return Navigator.of(context).pushNamed('/'+name,arguments: data);

  }else{
    return Navigator.of(context).pushNamed('/'+name);

  }


 }



}
