import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/aboutus/about_us_response.dart';
import 'package:shradha_design/ui/aboutus/AboutUsBloc.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';


class AboutUsScreen extends StatefulWidget {
  @override
  AboutUsScreenState createState() {
    return AboutUsScreenState();
  }
}



class AboutUsScreenState extends State<AboutUsScreen>  with TickerProviderStateMixin  {


  AnimationController _animationController;
  AboutBloc _bloc ;//= HomeBloc();




  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }





  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");


    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _bloc = AboutBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();

    super.initState();

  }




  void callApi(){

    _bloc.getsub_subcat(false);

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
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),

          child: FutureBuilder<bool>(
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







                        bannerBuild(),




                      ],
                    )
                ) ;
              }
            },
          ),


        ),




      ),
    );




  }









Widget newArival(){


  return Column(

    children: [




      bannerBuild(),




    ],
  );

}





  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<AboutUsResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {

          return Column(

            children: [



              SizedBox(
                height: 10,
              ),

              Text(snapshot.data.data.title,style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

              Image.asset('assets/images/home_line.png',height: 10,),

              SizedBox(
                height: 10,
              ),


              Container(
                child: Text(snapshot.data.data.content,style: AppTheme.subtitleroboto.copyWith(fontSize: 14),),
              ),

              SizedBox(
                height: 10,
              ),





            ],
          );

        }else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }  else {
          return  CommonLoading();
        }
      },
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






















}



