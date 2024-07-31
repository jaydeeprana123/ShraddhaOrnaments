import 'package:package_info/package_info.dart';

class BuildConfigData{

  Future<PackageInfo> getAppData()async{

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;

  }


}