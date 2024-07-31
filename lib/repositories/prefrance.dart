import 'dart:core';
import 'package:shradha_design/constant/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shradha_design/response/login/login_response.dart';


class   PreferencesHelper {



     static const String PREF_NAME = "ShradhaDesgin";

     static const String KEY_USER_ID = "userId";
     static const String KEY_USER_EMAIL = "userEmail";
     static const String KEY_USER_FNAME = "fname";
     static const String KEY_USER_LNAME = "lanme";
     static const String KEY_USER_PHONE = "phone";

     static const String KEY_PRICE_SHOW = "priceShow";
     static const String KEY_LOCATION_SHOW = "locationShow";

     static const String KEY_FCM_TOKEN = "fcm_token";
     static const String KEY_TOKEN = "token";
     static const String KEY_PASSCODE = "passcode";
     static const String KEY_DEVICE_INFO = "device_info";
     static const String KEY_LOGGED_STATUS = "logged";
     static const String KEY_LOGGED_VIEW = "loggedView";
     static const String KEY_REVIEW_STATUS = "review";
     static const String KEY_USER_PHOTO = "profile_pic";

     static const String KEY_SPLACE_PHOTO = "splace_image";
     static const String KEY_SPLCE_LOGO = "splace_logo";

     static const String KEY_PAYMENT = "payment";


     static const String KEY_CONTACT = "contect_phone";



     static SharedPreferences pref ;


    prefrence() async  {
          pref = await SharedPreferences.getInstance();

     }




    Future<bool> login(LoginResponse response )async{

     // pref = await SharedPreferences.getInstance();
      if(pref==null){
        pref = await SharedPreferences.getInstance();
      }

      pref.setString(KEY_USER_ID, response.data.id.toString());
      pref.setString(KEY_USER_EMAIL, response.data.email);
      pref.setString(KEY_USER_FNAME, response.data.firstname);
      pref.setString(KEY_USER_LNAME, response.data.lastname);
      pref.setString(KEY_USER_PHONE, response.data.mobile);

      if(response.data.image!=null){
        pref.setString(KEY_USER_PHOTO, response.data.image);
      }

      if(response.data.securityCode!=null){
        pref.setString(KEY_PASSCODE, response.data.securityCode);
      }

      if(response.data.token!=null){
        pref.setString(KEY_TOKEN, response.data.token);
      }



      LogCustom.logd("xxxxxxx login sucess in prefance");


      return true;

    }



   setUserIdAndEmail(String userId,String email,String zipcode){


     pref.setString(KEY_USER_ID, userId);
     pref.setString(KEY_USER_EMAIL, email);
     LogCustom.logd("xxxxxxx login sucess in prefance setUserIdAndEmail");

   }

     setuserid(String userId) {
       pref.setString(KEY_USER_ID, userId) ;
     }


   setFcmTocken(String fcmtocken) {
      pref.setString(KEY_FCM_TOKEN, fcmtocken) ;
   }


    String  getFCMToken() {

     return pref.getString(KEY_FCM_TOKEN)?? "";
   }


 String  getToken() {

     return pref.getString(KEY_TOKEN)?? "";
   }

     String  getsecurityCode() {

       return pref.getString(KEY_PASSCODE)?? "";
     }

    setPayment(String fcmtocken) {
      pref.setString(KEY_PAYMENT, fcmtocken) ;
   }

    String  getPayment() {
     return pref.getString(KEY_PAYMENT)?? "2";
   }


     setPhoto(String fcmtocken) {
       pref.setString(KEY_USER_PHOTO, fcmtocken) ;
     }



     String  getContactPhone() {
       return pref.getString(KEY_CONTACT)?? "";
     }

       setcontactPhone(String phone) {
       pref.setString(KEY_CONTACT, phone) ;

     }




     String  getsplceImage() {
       return pref.getString(KEY_SPLACE_PHOTO)?? "";
     }

     String  getsplacelogo() {
       return pref.getString(KEY_SPLCE_LOGO)?? "";
     }


     setSplaceBg(String fcmtocken) {
       pref.setString(KEY_SPLACE_PHOTO, fcmtocken) ;
     }

     setSplacelogo(String fcmtocken) {
       pref.setString(KEY_SPLCE_LOGO, fcmtocken) ;
     }



     setDeviceInfo(String deviceinfo) {
       pref.setString(KEY_DEVICE_INFO, deviceinfo) ;
     }


     String getDeviceInfo() {

       return pref.getString(KEY_DEVICE_INFO)?? "";
     }








     String getEmail() {
       return pref.getString(KEY_USER_EMAIL)?? "";
     }






     String getfname() {
       return pref.getString(KEY_USER_FNAME)??"";
     }

      String getlname() {
       return pref.getString(KEY_USER_LNAME)??"";
     }


     setToPriceShow(String priceShow) {
       pref.setString(KEY_PRICE_SHOW, priceShow) ;
     }


     String getPriceToShow() {
       return pref.getString(KEY_PRICE_SHOW)??"";
     }


     setLocationToShowInRajkot(String isLocationShow) {
       pref.setString(KEY_LOCATION_SHOW, isLocationShow) ;
     }


     String getLocationToShowInRajkot() {
       return pref.getString(KEY_LOCATION_SHOW)??"";
     }



    String getUserId() {
     return pref.getString(KEY_USER_ID)??"0";
   }


     String getphoto() {
       return pref.getString(KEY_USER_PHOTO)??"0";
     }



   logout() {
     pref.setString(KEY_USER_ID, "");
     pref.setString(KEY_FCM_TOKEN, "");
     pref.setBool(KEY_LOGGED_STATUS, false);
     pref.setString(KEY_SPLACE_PHOTO, "");

   }

     setReview(bool status) {
       pref.setBool(KEY_REVIEW_STATUS, status);
     }

     bool isReviewed()  {
       return pref.getBool(KEY_REVIEW_STATUS)??false;
     }



     setLoginview(bool status) {
       pref.setBool(KEY_LOGGED_VIEW, status);
     }

     bool isLoginView()  {
       return pref.getBool(KEY_LOGGED_VIEW)??false;
     }




     setLogin(bool status) {
       pref.setBool(KEY_LOGGED_STATUS, status);
     //UserModel.setISLOGIN(status);
     }

    bool isLogged()  {

     //  LogCustom.loge("xxxxxxxxxxx","isLogged"+ UserModel.getCartId());
      //pref = await SharedPreferences.getInstance();
     return pref.getBool(KEY_LOGGED_STATUS)??false;
   }






}

