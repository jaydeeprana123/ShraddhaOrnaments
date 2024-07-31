import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/profile/profileBloc.dart';
import 'package:shradha_design/ui/profile/profile_edit.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/app_theme.dart';


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
    padding: EdgeInsets.only(left: 5,right: 5),
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
              Text("My Profile",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

              Image.asset('assets/images/home_line.png',height: 10,),

            ],
          ),
        ),

        SizedBox(
          height: 25,
        ),




        Container(
          // color: AppTheme.primarydark,
          child: Row(
            children: [
              Expanded(
                  child:Container(
                    // padding: EdgeInsets.all(10),
                    //color: AppTheme.primarydark,
                    child: Text("Personal Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18,fontWeight: FontWeight.w500),),
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

                          Image.asset('assets/images/my_profile_edit.png',height: 20,),
                          SizedBox(width: 5,),
                          Text("Edit Profile",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontSize: 16,fontWeight: FontWeight.w500),)

                        ],
                      ),
                    ),
                  ) ),

            ],
          ),
        ),


        SizedBox(
          height: 20,
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

          padding: EdgeInsets.all(10),
          child: Row(
            children: [



              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppTheme.gray_300, offset: const Offset(0, 4), blurRadius: 2,),

                  ],

                ),

                padding: EdgeInsets.all(2),

                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl:bloc.subject.value.data.image,
                  height: 85,
                  width: 85,
                  errorWidget: (context, url, error) => Icon(Icons.account_circle),
                  placeholder: (context, url) => Icon(Icons.account_circle),
                ),
              ),






              SizedBox(
                width: 5,
              ),


              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Icon(Icons.person,color: AppTheme.black_800,size: 18,),
                        SizedBox(width: 10,),
                        Text(bloc.subject.value.data.firstname+" "+bloc.subject.value.data.lastname,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 16,color: AppTheme.black_text_dark),)
                      ],
                    ),

                    SizedBox(height: 8,),


                    Row(
                      children: [

                        Icon(Icons.email,color: AppTheme.black_800,size: 18,),
                        SizedBox(width: 10,),
                        Text(bloc.subject.value.data.email,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),),
                      ],
                    ),



                    SizedBox(height: 8,),


                    Row(
                      children: [

                        // Icon(Icons.call,color: AppTheme.black_800,size: 18,),
                        Image.asset('assets/images/p_phone.png',height: 15,),
                        SizedBox(width: 10,),
                        Text(bloc.subject.value.data.mobile,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),),
                      ],
                    ),



                  ],
                ),
              ),




            ],
          ),
        ),

        SizedBox(
          height: 15,
        ),



        Container(
          // color: AppTheme.primarydark,
          child: Row(
            children: [
              Expanded(
                  child:Container(
                    // padding: EdgeInsets.all(10),
                    //color: AppTheme.primarydark,
                    child: Text("Company Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18,fontWeight: FontWeight.w500),),
                  ) ),


            ],
          ),
        ),


        SizedBox(
          height: 15,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Image.asset('assets/images/p_cname.png',height: 20,),
                        //Icon(Icons.work,color: AppTheme.black_800,size: 20,),
                        SizedBox(width: 10,),
                        Text(bloc.subject.value.data.companyName+"\n"+bloc.subject.value.data.mobile,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),),
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
          height: 15,
        ),



        Container(
          alignment: Alignment.topLeft,
          child: Text("Address Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18,fontWeight: FontWeight.w500),),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Image.asset('assets/images/p_address.png',height: 25,),
                    // Icon(Icons.pin_drop,color: AppTheme.black_800,size: 20,),
                    SizedBox(width: 10,),




                     Expanded(child: RichText(
                  text: TextSpan(
                    style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),
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
                          Expanded(child: Text("sdsdsds  sdsdsds fsdsdsd dfdfdf  asasasas asasasas    "+bloc.subject.value.data.companyAddress1+","+bloc.subject.value.data.companyAddress2,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),maxLines:4,textAlign: TextAlign.start,),),
                          Text(bloc.subject.value.data.city+","+bloc.subject.value.data.state+","+bloc.subject.value.data.country,style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 14),textAlign: TextAlign.start,),
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



