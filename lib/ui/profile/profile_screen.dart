import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/profile/profileBloc.dart';
import 'package:shradha_design/ui/profile/profile_edit.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/app_theme.dart';

import '../../utils/my_icons.dart';


class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}



class ProfileScreenState extends State<ProfileScreen>  with TickerProviderStateMixin  {





  ProfileBloc bloc;



  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");

    bloc=ProfileBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient);



    callApi();






    super.initState();



  }






  void callApi(){


    bloc.getuserdata();

  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");


    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: FutureBuilder<bool>(
        future: _getDelayed(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            return  Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10,right: 10) ,


                child: Column(
                  children: [


                    Expanded(
                      child: dataBuild(),
                    ),



                  ],
                ),
            ) ;
          }
        },
      ),




    );



  }






  Widget dataBuild() {
    return StreamBuilder(

      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<LoginResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {


          return newArival();


        }else if (snapshot.hasError ) {
          return CommonError( error: snapshot.error.toString(),);
        }
        else {
          return CommonLoading();
        }
      },
    );
  }







  Widget newArival(){


  return Container(
    padding: EdgeInsets.all(16),
    child: ListView(
     physics: NeverScrollableScrollPhysics(),
      children: [

        SizedBox(
          height: 10,
        ),

        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("My Profile",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 16),),
              //
              // Image.asset('assets/images/home_line.png',height: 10,),

            ],
          ),
        ),

        SizedBox(
          height: 16,
        ),




        Container(
          // color: AppTheme.primarydark,
          child: Row(
            children: [
              Expanded(
                  child:Container(
                    // padding: EdgeInsets.all(10),
                    //color: AppTheme.primarydark,
                    child: Text("Personal Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black_text_dark,fontSize: 16,fontWeight: FontWeight.w500),),
                  ) ),

              Expanded(
                  child:Container(
                    alignment: Alignment.centerRight,
                    // padding: EdgeInsets.all(10),
                    //color: AppTheme.primarydark,
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUpdateScreen()),).whenComplete(() {

                          setState(() {
                            callApi();

                          });
                        });

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Image.asset('assets/images/my_profile_edit.png',height: 16,color: AppTheme.primarydark,),
                          SizedBox(width: 5,),
                          Text("Edit Profile",style: AppTheme.subtitle.copyWith(color: AppTheme.primarydark,fontSize: 15,fontWeight: FontWeight.w400),)

                        ],
                      ),
                    ),
                  ) ),

            ],
          ),
        ),


        SizedBox(
          height: 10,
        ),

        Container(

          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.gray_300,
                offset: const Offset(0, 4),
                blurRadius: 2,

              ),

            ],

          ),

          padding: EdgeInsets.all(12),
          child: Row(
            children: [



              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child:

                  FadeInImage.assetNetwork(
                    placeholder: user,
                    image:bloc.subject.value.data.image,
                    fit: BoxFit.fill,
                    height: 85,
                    width: 85,
                  ),

                ),
              ),






              SizedBox(
                width: 5,
              ),


              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,


                    children: [



                      Row(
                        children: [

                          Icon(Icons.person,color: AppTheme.black_800,size: 20,),
                          SizedBox(width: 10,),
                          Expanded(child: Text(bloc.subject.value.data.firstname+" "+bloc.subject.value.data.lastname,style: AppTheme.subtitleopensans.copyWith(fontSize: 16,color: AppTheme.black_text_dark),))
                        ],
                      ),

                      SizedBox(height: 8,),


                      Row(
                        children: [

                          Icon(Icons.email,color: AppTheme.black_800,size: 20,),
                          SizedBox(width: 10,),
                          Expanded(child: Text(bloc.subject.value.data.email,style: AppTheme.subtitleopensans.copyWith(fontSize: 13),)),
                        ],
                      ),



                      SizedBox(height: 8,),


                      Row(
                        children: [

                          // Icon(Icons.call,color: AppTheme.black_800,size: 18,),
                         Icon(Icons.phone, color: AppTheme.black_800,size: 20,),
                          SizedBox(width: 10,),
                          Expanded(child: Text(bloc.subject.value.data.mobile,style: AppTheme.subtitleopensans.copyWith(fontSize: 13),)),
                        ],
                      ),



                    ],
                  ),
                ),
              ),




            ],
          ),
        ),

        SizedBox(
          height: 30,
        ),



        Container(
          // color: AppTheme.primarydark,
          child: Row(
            children: [
              Expanded(
                  child:Container(
                    // padding: EdgeInsets.all(10),
                    //color: AppTheme.primarydark,
                    child: Text("Company Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black_text_dark,fontSize: 16,fontWeight: FontWeight.w500),),
                  ) ),


            ],
          ),
        ),


        SizedBox(
          height: 10,
        ),

        Container(
          //color: AppTheme.white,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.gray_300,
                offset: const Offset(0, 4),
                blurRadius: 2,

              ),

            ],

          ),

          padding: EdgeInsets.all(10),
          child: Row(
            children: [


              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(Icons.business_center, color: AppTheme.black_800,size: 20),
                        //Icon(Icons.work,color: AppTheme.black_800,size: 20,),
                        SizedBox(width: 10,),
                        Text(bloc.subject.value.data.companyName+"\n"+bloc.subject.value.data.mobile,style: AppTheme.subtitleopensans.copyWith(fontSize: 13),),
                      ],
                    ),



                    SizedBox(height: 5,),




                  ],
                ),
              ),



            ],
          ),
        ),


        SizedBox(
          height: 30,
        ),




        Container(
          alignment: Alignment.topLeft,
          child: Text("Address Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black_text_dark,fontSize: 16,fontWeight: FontWeight.w500),),
        ),

        SizedBox(
          height: 10,
        ),

        Container(
          // color: AppTheme.white,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.gray_300,
                offset: const Offset(0, 4),
                blurRadius: 2,

              ),

            ],

          ),

          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Column(
              //direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon(Icons.location_on, color: AppTheme.black_800,size: 20),
                    // Image.asset('assets/images/p_address.png',height: 18,color: AppTheme.black_800,),
                    // Icon(Icons.pin_drop,color: AppTheme.black_800,size: 20,),
                    SizedBox(width: 10,),




                     Expanded(child: RichText(
                  text: TextSpan(
                    style: AppTheme.subtitleopensans.copyWith(fontSize: 13),
                    children: <TextSpan>[
                      TextSpan(text: bloc.subject.value.data.companyAddress1+","+bloc.subject.value.data.companyAddress2),
                      TextSpan(text: "\n"+bloc.subject.value.data.city+","+bloc.subject.value.data.state+","+bloc.subject.value.data.country),
                    ],
                  ),
                ),)



                    /*Container(
                      height: 500,
                      child: Column(
                        //direction: Axis.vertical,
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Text("sdsdsds  sdsdsds fsdsdsd dfdfdf  asasasas asasasas    "+bloc.subject.value.data.companyAddress1+","+bloc.subject.value.data.companyAddress2,style: AppTheme.subtitleopensans.copyWith(fontSize: 13),maxLines:4,textAlign: TextAlign.start,),),
                          Text(bloc.subject.value.data.city+","+bloc.subject.value.data.state+","+bloc.subject.value.data.country,style: AppTheme.subtitleopensans.copyWith(fontSize: 13),textAlign: TextAlign.start,),
                        ],
                      ),
                    )*/

                  ],
                ),



                SizedBox(height: 5,),




              ],
            ),
          ),
        ),







      ],
    ),
  );

}






  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    bloc.dispose();

    super.dispose();
  }






















}



