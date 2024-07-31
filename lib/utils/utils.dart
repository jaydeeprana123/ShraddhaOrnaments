import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils{

 static String currencyText(String price){

  double dd=double.parse(price);

  String pp =dd.toStringAsFixed(dd.truncateToDouble().toString() == price ? 0 : 2);

  return pp;
 }




 static String twodigitText(String price){

 if(price.length==2){
  return price;
 }else{

  return "0"+price;
 }


 }





 static String removeLastChar(String str) {
  return str.substring(0, str.length - 1);
 }


 static int getColorFromHex(String hexColor) {

  try{
      hexColor = hexColor.toUpperCase().replaceAll('#', '');
      if (hexColor.length == 6) {
       hexColor = 'FF' + hexColor;
      }
      return int.parse(hexColor, radix: 16);

  }on Exception catch (_) {
   print('xxxxx Exeption::');
    return int.parse("FFFFFFFF", radix: 16);
  }

 }


 String setDeliveryDate(DateTime date){

  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(date);
  return formatted;

 }



 String setTime(DateTime date){

  var formatter = new DateFormat('hh:mm a');
  String formatted = formatter.format(date);
  return formatted;

 }

 String getDeliveryDate(String date){

  var newDateTimeObj2 = new DateFormat("yyyy-MM-dd").parse(date);
// var dateFormate = DateFormat("EEEEEE, MMMMM dd, yyyy hh:mm:ss a").format(DateTime.parse(date));


  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(newDateTimeObj2);
  return formatted;

 }



/*


 static  pushName(BuildContext  context, String  name,var argument) {







    if(argument!=null){
     Navigator.pushNamed(context, '/'+name,arguments: argument);
    }else{
     Navigator.pushNamed(context, '/'+name );
    }



    var route = ModalRoute.of(context);

    if(route!=null){

     LogCustom.logd("xxxxxx page name:"+route.settings.name);
     // LogCustom.logd("xxxxxx page name:"+route.barrierLabel);
     LogCustom.logd("xxxxxx page isCurrent:"+route.isCurrent.toString());
     LogCustom.logd("xxxxxx page isActive:"+route.isActive.toString());
     LogCustom.logd("xxxxxx page isFirst:"+route.isFirst.toString());



    }





 }

*/






String getsheduledate(String date){

 var newDateTimeObj2 = new DateFormat("EEEEEE, MMMM dd, yyyy hh:mm:ss a").parse(date.replaceAll("am", "AM").replaceAll("pm", "PM"));
// var dateFormate = DateFormat("EEEEEE, MMMMM dd, yyyy hh:mm:ss a").format(DateTime.parse(date));


 var formatter = new DateFormat('EEEEEE, MMMM dd, yyyy');
 String formatted = formatter.format(newDateTimeObj2);
 return formatted;

}

 String getsheduletime(String date){


  var newStr = date.substring(0,10) + ' ' + date.substring(11,23);

  DateTime dt = DateTime.parse(newStr);

  //var newDateTimeObj2 = new DateFormat("EEE, d MMM yyyy").parse(newStr);
  //var newDateTimeObj2 = new DateFormat("yyyy-MM-dd").parse(date);


  var formatter = new DateFormat('EEE, d MMM yyyy');
  // var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(dt);
  return formatted;



  /* var newDateTimeObj2 = new DateFormat("EEEEEE, MMMM dd, yyyy hh:mm:ss a").parse(date.replaceAll("am", "AM").replaceAll("pm", "PM"));
  var formatter = new DateFormat('hh:mm:ss a');
  String formatted = formatter.format(newDateTimeObj2);
  return formatted;
*/
 }









 static String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );

  return htmlText.replaceAll(exp, '');
 }




 static void  launchWhatsApp({String phone}) async {




  String url() {

   if (Platform.isIOS) {

   // String ss=phone.replaceAll(" ", "");

    return "whatsapp://wa.me/$phone/?text=${Uri.parse("Hi")}";
   } else {

    return "whatsapp://send?phone=$phone&text=${Uri.parse("Hi")}";
    // return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    //  return "https://wa.me/message/QYCAF23UXTWZG1";
   }
  }

  try{

    await launch(url());

  }catch(e){
   await FlutterLaunch.launchWhatsapp(phone: phone, message: "Hi");

   print(e);
  }


 }




}
