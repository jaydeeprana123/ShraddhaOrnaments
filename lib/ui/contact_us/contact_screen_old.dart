import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/common/common_response.dart';
import 'package:shradha_design/ui/contact_us/ContactBloc.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';


class CountactUsScreen extends StatefulWidget {
  @override
  CountactUsScreenState createState() {
    return CountactUsScreenState();
  }
}



class CountactUsScreenState extends State<CountactUsScreen>  with TickerProviderStateMixin  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  ContactBloc _bloc ;//= HomeBloc();


  List<String> data=["","","","",""];


  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");


    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

          _bloc = ContactBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();






    super.initState();



  }






  void callApi(){

    _bloc.getcontact(false);


  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      backGroundColor: AppTheme.bg,
      showDrawer: false,
        showFAB: false,
        bodyData: Scaffold(
          backgroundColor: AppTheme.bg,
          body: FutureBuilder<bool>(
            future: _getDelayed(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              } else {
                return  Container(

                   /* decoration: BoxDecoration(

                      image: DecorationImage(
                        image: const AssetImage("assets/images/bg.jpg"),
                        fit: BoxFit.fill,

                      ),

                    ),*/

                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 10,right: 10) ,
                    child: Column(
                      children: [


                        Expanded(
                          child: bannerBuild(),
                        ),

                      ],
                    )
                ) ;
              }
            },
          )



        ),
    );


  }



  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<CommonResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {

          return newArival(snapshot.data);

        }else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }  else {
          return  CommonLoading();
        }
      },
    );
  }






Widget newArival(CommonResponse data){


  return Column(

    children: [

      SizedBox(
        height: 10,
      ),

      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Contact Us",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

            Image.asset('assets/images/home_line.png',height: 10,),

          ],
        ),
      ),

      SizedBox(
        height: 15,
      ),




     Container(
       padding: EdgeInsets.all(15),
       child: Column(
         children: [


           InkWell(
             onTap: (){


               if(data.data.address!=null){
                 _lunchMap(data.data.address);
               }


             },
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [

                 // Icon(Icons.home,color: AppTheme.primary,size: 25,),

                 Container(
                   height: 30,
                   width: 30,
                   color: AppTheme.primary,
                   padding: EdgeInsets.all(4),
                   child: Image.asset('assets/images/home_pink.png',height: 20),
                 ),




                 // SizedBox(width: 15,),


                 Expanded(child: Container(
                   // margin: EdgeInsets.only(right: 5,left: 5),
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       color: AppTheme.white,
                       border: Border.all(color: AppTheme.primary, width: 1,),
                       borderRadius: BorderRadius.circular(1.0)
                   ),

                   child:Text(data.data.address,style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text,fontSize: 14),),



                 ),)



               ],
             ),
           ),


           SizedBox(
             height: 15,
           ),



           InkWell(
             onTap: (){

              if(data.data.phone!=null ){
                _launchCaller(data.data.phone);
              }


             },
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [

                 //Icon(Icons.pho,color: AppTheme.primary,size: 25,),


                 Container(
                   height: 30,
                   width: 30,

                   color: AppTheme.primary,
                   padding: EdgeInsets.all(5),
                   child: Image.asset('assets/images/contact_pink.png',height: 15),
                 ),



                 //SizedBox(width: 15,),


                 Expanded(child: Container(
                   // margin: EdgeInsets.only(right: 5,left: 5),
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       color: AppTheme.white,
                       border: Border.all(color: AppTheme.primary, width: 1,),
                       borderRadius: BorderRadius.circular(1.0)
                   ),

                   child:Text(data.data.phone,style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text,fontSize: 16),),



                 ),)




               ],
             ),
           ),



           SizedBox(
             height: 15,
           ),



           InkWell(
             onTap: (){
               _launchURL(data.data.email.toString(),"Inquiry From Application","Hello");
             },
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   height: 30,
                   width: 30,

                   color: AppTheme.primary,
                   padding: EdgeInsets.all(4),
                   child: Icon(Icons.mail,color: AppTheme.white,size: 22,),
                 ),

                 // SizedBox(width: 15,),

                 Expanded(child: Container(
                   // margin: EdgeInsets.only(right: 5,left: 5),
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       color: AppTheme.white,
                       border: Border.all(color: AppTheme.primary, width: 1,),
                       borderRadius: BorderRadius.circular(1.0)
                   ),

                   child:Text(data.data.email,style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text,fontSize: 16),),



                 )),



               ],
             ),
           ),







           SizedBox(
             height: 15,
           ),




           Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               // Icon(Icons.mail,color: AppTheme.primary,size: 25,),


               Container(
                 height: 30,
                 width: 30,

                 color: AppTheme.primary,
                 padding: EdgeInsets.all(4),
                 child: Image.asset('assets/images/time_pink.png',height: 20),
               ),


              // SizedBox(width: 15,),


               Expanded(
                 child: Container(
                   // margin: EdgeInsets.only(right: 5,left: 5),
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                       color: AppTheme.white,
                       border: Border.all(color: AppTheme.primary, width: 1,),
                       borderRadius: BorderRadius.circular(1.0)
                   ),

                   child:Text("Monday to Saturday\n09:30 AM to 07:30 PM",style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text,fontSize: 16),),



                 ),
               ),




             ],
           ),


         ],
       ),
     ),



    ],
  );

}
















  void callSerachApi(String msg){
     // _bloc.getSearch(msg);
  }



















  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    _bloc?.dispose();
    _animationController.dispose();
    super.dispose();
  }





_lunchMap(String address)async{
    ///22.2961733,70.7693374
  //22.3006838,70.814801
  //22.30036	,70.82993
  //22.300059, 70.820078
  //MapsLauncher.launchQuery(address);
 // MapsLauncher.launchCoordinates(22.2961733,70.7693374);

  final availableMaps = await MapLauncher.installedMaps;

  await availableMaps.first.showMarker(
    coords: Coords(22.300071218643915, 70.82006807149646),
    title: address,
  );


}





  _launchCaller(String phone) async {

    List<String> number=phone.split("/");

    String ss=number[0].replaceAll(" ", "");


    debugPrint("number:::::::"+ss);

    String url = "tel://"+ss;
  //  String url = "tel://9428254081";

    await launch(url);
  }








  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';

    try{

      await launch(url);

      debugPrint("mail try:::::::");

    }catch(e){

      debugPrint("mail catch:::::::");


      final Email email = Email(
        body: body,
        subject: subject,
        recipients: [toMailId],
      //  cc: ['cc@example.com'],
       // bcc: ['bcc@example.com'],
       // attachmentPaths: ['/path/to/attachment.zip'],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);

    }

  }


}



