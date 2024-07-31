import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';

class   CommonLoading extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

     return Container(

        margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/3)),

        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: [

           // _imagedata(context),

            //Image(image: new AssetImage('assets/images/loading_logo.gif',)),


            //const Text("Loading data ...",style: AppTheme.subtitle,),




            const SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                strokeWidth: 5.0,
              ),
              height: 25.0,
              width: 25.0,

            ),

            const SizedBox(height: 20, ) ,

            const Text("Loading...",style: AppTheme.subtitle,),



          ],
      ),
     );
  }


 /* Widget _imagedata(BuildContext context) {
//https://cdn.theclassyhome.com/newimages/site/logo.gif


      *//*return Container(
        height: 100,
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.fitHeight,
            colorFilter: new ColorFilter.mode(Colors.white54, BlendMode.dstATop),
            image: AssetImage('assets/images/loading_logo.gif',),
          ),
        ),
      );
*//*
    return Image(image: new AssetImage('assets/images/loading_logo.gif',));


  }
*/


  }


