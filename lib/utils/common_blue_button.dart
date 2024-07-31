import 'package:flutter/material.dart';

import 'package:shradha_design/app_theme.dart';


class CommonBlueButton extends StatelessWidget {

  final String btnTitle;
  final Color color;
  VoidCallback onCustomButtonPressed;

  CommonBlueButton(this.btnTitle, this.onCustomButtonPressed,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
    //  margin: EdgeInsets.only(left: 14.w, right: 14.w),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x825468ff),
            blurRadius: 15.0,
            spreadRadius: 0,
            offset: Offset(0,5,),
          )
        ],

      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onCustomButtonPressed,
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: BorderSide(color: skygreen_24d39e, width: 0),
              ),
            ),
            child: Text(
              btnTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: AppTheme.rubik),
            )),
      ),
    );

  }
}
