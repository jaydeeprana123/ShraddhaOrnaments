
import 'package:flutter/material.dart';
import 'package:shradha_design/ui/aboutus/aboutUs_screen.dart';
import 'package:shradha_design/ui/cart/cart_screen.dart';
import 'package:shradha_design/ui/categorys/main_categories_screen.dart';
import 'package:shradha_design/ui/categorys/sub_categories_screen.dart';
import 'package:shradha_design/ui/categorys/sub_sub_categories_screen.dart';
import 'package:shradha_design/ui/contact_us/contact_screen.dart';
import 'package:shradha_design/ui/home/home_page.dart';
import 'package:shradha_design/ui/home/home_page_with_category.dart';
import 'package:shradha_design/ui/home/main_page.dart';
import 'package:shradha_design/ui/login/Login.dart';
import 'package:shradha_design/ui/login/PassCode.dart';
import 'package:shradha_design/ui/login/Register.dart';
import 'package:shradha_design/ui/order/order_details_screen.dart';
import 'package:shradha_design/ui/order/order_screen.dart';
import 'package:shradha_design/ui/productdetails/ZoomImageFragment.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'package:shradha_design/ui/profile/profile_screen.dart';
import 'package:shradha_design/ui/wishlist/wishlistlist_screen.dart';




class UIData {
  UIData._();

  //routes
  static const String mainpage = "/MainPage";
  static const String homePageFragment = "/HomePageFragment";
  static const String loginScreen = "/LoginScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String passcodeScreen = "/PasscodeScreen";
  static const String mainCategoriesScreen = "/MainCategoriesScreen";
  static const String subCategoriesScreen = "/SubCategoriesScreen";
  static const String subSubCategoriesScreen = "/SubSubCategoriesScreen";
  static const String cartScreen = "/CartScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String countactUsScreen = "/CountactUsScreen";
  static const String orderScreen = "/OrderScreen";
  static const String productDetailsScreen = "/ProductDetailsScreen";
  static const String wishListScreen = "/WishListScreen";
  static const String orderDetails = "/OrderDetailsScreen";
  static const String zoomImageData = "/ZoomImageFragment";
  static const String aboutUsScreen = "/AboutUsScreen";










 static final routes= <String, WidgetBuilder>{
   mainpage: (BuildContext context) => MainPage(),
    homePageFragment: (BuildContext context) => HomePageFragment(),
    loginScreen: (BuildContext context) => LoginScreen(),
    registerScreen: (BuildContext context) => RegisterScreen(),
    passcodeScreen: (BuildContext context) => PasscodeScreen(),
  mainCategoriesScreen: (BuildContext context) => HomePageWithCategories(),
  subCategoriesScreen: (BuildContext context) => SubCategoriesScreen(catId: ModalRoute.of(context).settings.arguments,),
  subSubCategoriesScreen: (BuildContext context) => SubSubCategoriesScreen(catId: ModalRoute.of(context).settings.arguments,),
  cartScreen: (BuildContext context) => CartScreen(),
  profileScreen: (BuildContext context) => ProfileScreen(),
  countactUsScreen: (BuildContext context) => CountactUsScreen(),
  orderScreen: (BuildContext context) => OrderScreen(),
  wishListScreen: (BuildContext context) => WishListScreen(),
  productDetailsScreen: (BuildContext context) => ProductDetailsScreen(pId:ModalRoute.of(context).settings.arguments,),
  orderDetails: (BuildContext context) => OrderDetailsScreen(orderId:ModalRoute.of(context).settings.arguments,),
  zoomImageData: (BuildContext context) => ZoomImageFragment(data:ModalRoute.of(context).settings.arguments,),
  aboutUsScreen: (BuildContext context) => AboutUsScreen(),

  };








}
