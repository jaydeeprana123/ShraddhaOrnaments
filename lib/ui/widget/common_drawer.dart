import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/interfaceclass/pagechangelistner.dart';
import 'package:shradha_design/network/globle_api.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:shradha_design/repositories/prefrance.dart';
import 'package:shradha_design/ui/aboutus/aboutUs_screen.dart';
import 'package:shradha_design/ui/changepassword/changepassword_scree.dart';
import 'package:shradha_design/ui/contact_us/contact_screen.dart';
import 'package:shradha_design/ui/login/Login.dart';
import 'package:shradha_design/ui/order/order_screen.dart';
import 'package:shradha_design/ui/productlist/best_seller_productlist_screen.dart';
import 'package:shradha_design/ui/productlist/new_arrival_productlist_screen.dart';
import 'package:shradha_design/ui/wishlist/wishlistlist_screen.dart';
import 'package:shradha_design/utils/page_transition.dart';

import '../../utils/cart_db.dart';
import '../../utils/my_icons.dart';


class CommonDrawer extends StatelessWidget  {


  final PageStateCallBack callBack;

  final PreferencesHelper pref=new PreferencesHelper();

   CommonDrawer({Key key, this.callBack}) : super(key: key);


  Future<bool> getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }





  @override
  Widget build(BuildContext context) {
    double  screenHeight = MediaQuery.of(context).size.height;

    LogCustom.logd("image ::"+pref.getphoto());


    return  Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors.transparent,
          splashColor: AppTheme.white,
          highlightColor: AppTheme.white,
          //canvasColor: AppTheme.primary,
          //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(


          child: SingleChildScrollView(
             // physics: AlwaysScrollableScrollPhysics(),

              child: Container(
                   height: screenHeight,
                  color: AppTheme.white,
                  child: Column(

                    children: [

                      Expanded(

                        child: SingleChildScrollView(
                          child: Column(

                            mainAxisSize: MainAxisSize.max,

                            children: <Widget>[


                             Row(
                               children: [

                                 Expanded(child:  Container(
                                   margin: EdgeInsets.only(top:22),
                                   padding: EdgeInsets.only(left: 5,right: 5,top: 26,bottom: 8),
                                   color: AppTheme.primarydark,
                                   height: 150,
                                   child: Column(
                                     children: [

                                       Container(
                                         // color: AppTheme.white,
                                         decoration: BoxDecoration(
                                           color: AppTheme.white,
                                           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                                         ),

                                         padding: EdgeInsets.all(2),
                                         child: ClipRRect(
                                             borderRadius: BorderRadius.circular(50.0),

                                             child: CachedNetworkImage(
                                               fit: BoxFit.fill,
                                               imageUrl:pref.getphoto(),
                                               height: 65,
                                               width: 65,
                                               errorWidget: (context, url, error) => Icon(Icons.account_circle,size:65),
                                               placeholder: (context, url) => Icon(Icons.account_circle,size:65),
                                             )
                                         ),
                                       ),





                                       SizedBox(
                                         width:8,
                                       ),


                                       Expanded(
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,

                                           children: [

                                             SizedBox(height: 3,),

                                             Text(pref.getfname()+" "+pref.getlname(),style: AppTheme.subtitleopensans.copyWith(color: AppTheme.white,fontSize: 16,fontWeight: FontWeight.w300),),

                                             SizedBox(height: 3,),

                                             Text(pref.getEmail(),style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontSize: 14,fontWeight: FontWeight.w200),),

                                           ],)
                                         ,
                                       ),



                                     ],
                                   ),

                                 ),)

                               ],
                             ),



                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);


                                    /*if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="MainCategoriesScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainCategoriesScreen()),);

                                    }*/


                                    callBack.pageChange(1);

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 28,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(category,fit: BoxFit.fitHeight,height: 18, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Categories",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),


                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewArrivalProductList()),);


                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(new_arrival,fit: BoxFit.fitHeight,height: 18, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("New Arrival",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),

                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BestSellerProductList()),);


                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(best_seller,fit: BoxFit.fitHeight,height: 18, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Best Seller",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),

                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="CartScreen"){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);

                                      PageTransition.createRoutedata(context,"CartScreen",null);

                                    }
                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(my_cart,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Cart",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),






                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="OrderScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()),);

                                    }

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(my_order,fit: BoxFit.fitHeight,height: 18, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("My Order",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),




                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="WishListScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WishListScreen()),);

                                    }

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        //Image.asset('assets/images/order.png',fit: BoxFit.fitHeight,height: 18,),

                                        SvgPicture.asset(heart,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),

                                        const SizedBox(width: 12,),
                                        Text("Wishlist",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),




                              Divider(
                                color: AppTheme.gray_300,
                              ),



                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="AboutUsScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()),);

                                    }

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(about,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("About Us",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),




                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="CountactUsScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountactUsScreen()),);

                                    }
                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(contact,fit: BoxFit.fitHeight,height: 18, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Contact Us",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),



                              Divider(
                                color: AppTheme.gray_300,
                              ),


                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    callBack.pageChange(4);

                                   // if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="ProfileScreen"){

                                     // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);

                                    //}

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(profile,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("My Profile",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),





                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);

                                    if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="ChangePasswordScreen"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()),);

                                    }
                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(password,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Change Password",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),










                              InkWell(
                                  onTap: (){

                                    _logout(context);
                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(logout,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("LogOut",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),

                              Divider(
                                color: AppTheme.gray_300,
                              ),

                              // Delete account permanently
                              InkWell(
                                  onTap: (){

                                    _deleteAccountDialog(context);
                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[

                                        SvgPicture.asset(delete_account,fit: BoxFit.fitHeight,height: 20, color: AppTheme.black_grey),
                                        const SizedBox(width: 12,),
                                        Text("Delete Account",style: AppTheme.menutext),

                                      ],

                                    ),)

                              ),

                              Divider(
                                color: AppTheme.gray_300,
                              ),


                              InkWell(
                                  onTap: (){

                                  },
                                  child:Container(
                                    //color: Colors.red,
                                    padding: const EdgeInsets.only(left: 25 ,top: 12,bottom: 12),

                                    child: Row(
                                      children: <Widget>[


                                        Icon(Icons.info_outline,size: 20,color: AppTheme.black_800,),


                                        const SizedBox(width: 12,),
                                        Text("V "+Constant.versionName,style: AppTheme.menutext.copyWith(fontSize: 14))

                                      ],

                                    ),)

                              ),



                              const SizedBox(
                                height: 18,
                              ),







                            ],
                          ),
                        )
                      ),

                      const SizedBox(
                        height: 10,
                      ),






                    ],
                  ),

              ),
          ),)
    );



  }











  _logout(BuildContext context)  async{
     showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text('Are you sure ?'),
        content: new Text('Do you want to logout?' ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: AppTheme.subtitlequicksand.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.black_text)),
          ),
          new TextButton(
            onPressed: () async {



              ApiClient ap =  BlocProvider.of<AppBloc>(context).appRepository.apiClient;
              GlobleApi.logout(ap);

              ap.pref.logout();


              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginScreen()), (Route<dynamic> route) => false);

              //Navigator.of(context).pop();
              //Navigator.of(context).pop();




            } ,
            child: new Text('Yes',style: AppTheme.subtitlequicksand.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.black_text)),
          ),
        ],
      ),
    );
  }


  _deleteAccountDialog(BuildContext context)  async{
    showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text('Are you sure ?'),
        content: new Text('Do you want to delete account permanently?' ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: AppTheme.subtitlequicksand.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.black_text)),
          ),
          new TextButton(
            onPressed: () async {

              ApiClient ap =  BlocProvider.of<AppBloc>(context).appRepository.apiClient;
              GlobleApi.deleteAccount(ap);

              ap.pref.logout();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginScreen()), (Route<dynamic> route) => false);

              //Navigator.of(context).pop();
              //Navigator.of(context).pop();




            } ,
            child: new Text('Yes',style: AppTheme.subtitlequicksand.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.black_text)),
          ),
        ],
      ),
    );
  }


  }



