import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';

class DeviceInfo{

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();




    isIpad(BuildContext context) async{

    if(Platform.isIOS){
      IosDeviceInfo iosinfo= await deviceInfo.iosInfo;
      LogCustom.logd("xxxxxxxxxx::model :"+iosinfo.name);

      if(iosinfo.name.toLowerCase().contains("ipad")){
        Constant.isIpad=true;
      }
    }else{


      final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

      LogCustom.logd("xxxxxxxxxx::model :"+data.size.shortestSide.toString());

      Constant.isIpad= data.size.shortestSide < 600 ? false:true ; //'phone' :'tablet';
    }


  }


}