import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();


  static const Color primary_logo_bg = Color(0xFFfd0575);
  static const Color primary = Color(0xFFE2057B);//Colors.yellowAccent;
 // static const Color primary = Color(0xFFEC268F);//Colors.yellowAccent;
  static const Color primarydark = Color(0xFF990B47);
  static const Color light_primarydark = Color(0x2f990B47);
  static const Color light_primarydark1 = Color(0x08990B47);
  //static const Color primarydark = Color(0xFFAD1457);


  static const light_violate = Color(0xfff4ebfe);
  static const light_yellow = Color(0xffFFFFCC);
  static const light_pink = Color(0xffffeaed);
  static const light_green = Color(0xffe6fbe6);




  static const Color background = Color(0xFFF7F7F7);
  static const Color transparent = Color(0x00000000);
  static const Color nearlyDarkBlue = Color(0xFFC62828);

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg_editText = Color(0xF7FFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color bg1 = Color(0xFFF7F7F7);
  static const Color bg = Color(0xFFfcfcfc);


  // static const Color bg = Color(0xFFFFFFFF);
  static const Color edit_bg = Color(0xFFF7F7F7);
  static const Color bg2 = Color(0xFFF7F7F7);
  static const Color blue = Color(0xFF0000FF);
  static const Color facebook = Color(0xFF237CEE);
  static const Color orange = Color(0xFFFBAE17);//Colors.orange;
  static const Color cyan = Color(0xFF00FFFF);//Colors.cyan;

  static const Color yello = Colors.yellowAccent;
  static const Color pending = Color(0xFFFDC830);
  static const Color light_grey = Color(0xFFD3D3D3);
  static const Color off_White = Color(0xFFE8E8E8);
  static const Color bone_white = Color(0xFFFAF9F6);
  static const Color light_black = Color(0xFF454545);

  static const Color off_White_bg = Color(0xfff2f3f2);
  static const Color off_White_bg1 = Color(0x7ff2f3f2);
  static const Color off_White_bg2 = Color(0x80f2f3f2);

  static const Color red = Colors.red;
  static const Color pink = Colors.pink;
  static const Color primaryblur = Color(0xFFFEF2F2);

  static const Color home1 = Color(0xFFFDC830);
  static const Color home2 = Color(0xFFFBB730);
  static const Color home3 = Color(0xFFF79634);


  static const Color green = Colors.green;
  static const Color green400 = Color(0xFF66BB6A);
  static const Color cancle = Color(0xFFB86132);

  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static const Color gray = Colors.grey;


  static const Color black = Colors.black;
  // static const Color black_text_dark = Color(0xEE232323);

  static const Color black_text_dark = Color(0xEE070707);
  static const Color black_text = Color(0xEE1f2937);
  static const light_text_color = Color(0xff4b5563);
  static const text_color = Color(0xff1f2937);
  static const medium_text_color = Color(0xff4b5563);
  static const hint_txt_798281 = Color(0xff798281);
  static const Color black_grey = Color(0xEE424242);
  static const Color black_grey_light = Color(0x7f424242);
  static const Color black_900 = Color(0xEE000000);
  static const Color black_800 = Color(0xA6000000);
  static const Color black_600 = Color(0x7B000000);
  static const Color black_500 =Color(0x61000000);


  static const Color gray_200 =    Color(0xFFEEEEEE);
  static const Color gray_300 =    Color(0xFFE0E0E0);
  static const Color gray_400 =  Color(0xFFBDBDBD);
  static const Color gray_500 =  Color(0xFF9E9E9E);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);


  static const String poppinsRegular = 'opensans';
  static const String quicksand = 'quicksand';
  static const String raleway = 'raleway';
  static const String rubik = 'rubik';
  static const String roboto = 'roboto';

  static const TextTheme textTheme = TextTheme(
   // display1: display1,
   // headline: headline,
    //title: title,
   // subtitle: subtitle,
   // body2: body2,
   // body1: body1,
    caption: caption,
  );

/*  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );*/

  /*static const TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.18,
    color: white,
  );

  static const TextStyle oleoText = TextStyle( // h6 -> title
    fontFamily: fontName2,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static  const TextStyle menuItem = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    letterSpacing: -0.04,
    color: black,
  );


*/


  static  const TextStyle menutext = TextStyle( // subtitle2 -> subtitle
    fontFamily: poppinsRegular,
    fontWeight: FontWeight.w200,
    fontSize: 15,
    letterSpacing: -0.04,
    color: black_text_dark,

  );




  static  const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: rubik,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle normalText = TextStyle( // subtitle2 -> subtitle
    fontFamily: rubik,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle subtitleroboto = TextStyle( // subtitle2 -> subtitle
    fontFamily: roboto,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle subtitlerobotosemi = TextStyle( // subtitle2 -> subtitle
    fontFamily: roboto,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );



  static  const TextStyle subtitlerubicSemi = TextStyle( // subtitle2 -> subtitle
    fontFamily: rubik,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );



  static  const TextStyle subtitleopensans = TextStyle( // subtitle2 -> subtitle
    fontFamily: poppinsRegular,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle subtitleRubik = TextStyle( // subtitle2 -> subtitle
    fontFamily: rubik,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle subtitleopensanssemibold = TextStyle( // subtitle2 -> subtitle
    fontFamily: poppinsRegular,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );


  static  const TextStyle subtitleraleway = TextStyle( // subtitle2 -> subtitle
    fontFamily: raleway,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );

  static  const TextStyle subtitlequicksand = TextStyle( // subtitle2 -> subtitle
    fontFamily: quicksand,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );
 static  const TextStyle subtitlequicksandsemibold = TextStyle( // subtitle2 -> subtitle
    fontFamily: quicksand,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );

static  const TextStyle subtitlequicksandmedum = TextStyle( // subtitle2 -> subtitle
    fontFamily: quicksand,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );




  static  const TextStyle subtitleralewaysemibold = TextStyle( // subtitle2 -> subtitle
    fontFamily: raleway,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );

  static  const TextStyle subtitleralewaybold = TextStyle( // subtitle2 -> subtitle
    fontFamily: raleway,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: -0.04,
    color: black_text,
  );



/*  static const TextStyle f13black = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: -0.04,
    color: darkText,
  );*/

 /* static const TextStyle subtitlegray = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: gray,
  );
*/




/*  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );*/

  /*static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );
*/
  static  const TextStyle caption = TextStyle( // Caption -> caption
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );


}
