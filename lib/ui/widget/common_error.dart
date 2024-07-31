import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';


class CommonError extends StatelessWidget {

  final String error;


  bool call=false;

  CommonError({@required this. error});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(


        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(error ,style: TextStyle(fontSize: 22,color: AppTheme.gray_500),),








            ],
          )),
    );

  }





  }


