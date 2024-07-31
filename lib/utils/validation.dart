

class Validation{


  static  bool isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }


 static String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

 static bool validateMobile(String value) {
   String pattern = r'^[0-9]{10}';
   RegExp regex = new RegExp(pattern);


   if (value.length == 10){
     if (regex.hasMatch(value) ) {
       return true;

     }else{
       return false;

     }
   } else{
     return false;

   }

  }



 static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }



 static bool isValidZip(String target) {

   String pattern = r'^[0-9]{5}(-[0-9]{4})?$';
  // String pattern2 = r'^[0-9]{9}';
   RegExp regExp = new RegExp(pattern);
  // RegExp regExp2 = new RegExp(pattern2);


   if (target!=null && ((target!="") || target.trim().length > 0)) {

     if (regExp.hasMatch(target) ) {

       if(target.length==5 ){
         return true;
       }else if(target.length==9){

         return true;

       } else if(target.length==10 && target.contains("-")){

         return true;
       }
       else {
         return false;
       }

     } else {
       return false;
     }

   } else {
     return false;
   }
 }


 static bool isvalidPhone(String target) {

   String pattern = r'^[0-9]{5}(-[0-9]{4})?$';
   // String pattern2 = r'^[0-9]{9}';
   RegExp regExp = new RegExp(pattern);
   // RegExp regExp2 = new RegExp(pattern2);


   if (target!=null && ((target!="") || target.trim().length > 0)) {

     if (regExp.hasMatch(target) ) {

       if(target.length==5 ){
         return true;
       }else if(target.length==9){

         return true;

       } else if(target.length==10 && target.contains("-")){

         return true;
       }
       else {
         return false;
       }

     } else {
       return false;
     }

   } else {
     return false;
   }
 }


}
