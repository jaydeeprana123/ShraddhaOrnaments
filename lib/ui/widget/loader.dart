import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/ui/widget/progress_dialog.dart';

class Pr{


  static ProgressDialog progressDialog;

   static show(context)async{


      LogCustom.logd("xxxxxxxxx ProgressDialog show");

      progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false,);
      progressDialog.style(message: "Please Wait");


    if (progressDialog.isShowing()) {
      await  progressDialog.hide();
    }

   await progressDialog.show();

    return true;

  }

  static hide(context){


    if(progressDialog==null){
      LogCustom.logd("xxxxxxxxx ProgressDialog hide");
      progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false,);
      //progressDialog.hide();
    }

    if (progressDialog.isShowing()) {
      progressDialog.hide();
    }

    return true;
  }


}