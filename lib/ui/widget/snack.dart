import 'package:flutter/material.dart';


enum SnackType{Info,error}

class Snack{
  Snack._();



  static showS(BuildContext context,String value){


    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value, style: new TextStyle(fontSize: 14.0),),
          duration: Duration(seconds: 3),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //backgroundColor: Colors.transparent,
        )
    );


  }



  static showInfo(BuildContext context,String value){


    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value, style: new TextStyle(fontSize: 14.0),),
          duration: Duration(seconds: 1),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
         // backgroundColor: Colors.green.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        )
    );


  }





  static showSTime(BuildContext context,String value,int second){


    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value, style: new TextStyle(fontSize: 14.0),),
          duration: Duration(seconds: second),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //backgroundColor: Colors.transparent,
        )
    );


  }



/*static show(GlobalKey<ScaffoldState> context,String value){

    LogCustom.logd("xxxxxx: network snackbar :");

    ScaffoldMessenger.of(context.currentContext).showSnackBar(
        SnackBar(
          content: Container(
            child: new Text(value, style: new TextStyle(fontSize: 14.0),),
          ),
          duration: Duration(seconds: 1),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          //backgroundColor: Colors.transparent,
        )
    );


  }
*/


}
