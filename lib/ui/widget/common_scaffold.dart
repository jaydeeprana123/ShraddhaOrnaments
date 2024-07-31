import 'package:flutter/material.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/ui/cart/cart_screen.dart';
import 'package:shradha_design/ui/search/SearchFragment.dart';
import 'package:shradha_design/ui/widget/common_drawer.dart';
import 'package:shradha_design/utils/page_transition.dart';
import 'package:shradha_design/utils/uidata.dart';
import '../../app_theme.dart';
import '../../utils/my_icons.dart';


class CommonScaffold extends StatelessWidget {
  final VoidCallback onFlatButtonPressed;
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final centerDocked;
  final showActionIcon;
  final elevation;
  final isWishListRemove;
  final isSearchRemove;
  final isCartRemove;
  Function actionclick;
  final Widget flotingActionButton;


  CommonScaffold({this.onFlatButtonPressed, this.appTitle,
    this.bodyData,
    this.showFAB = false,
    this.showDrawer = false,
    this.backGroundColor,
    this.actionFirstIcon = Icons.search,
    this.scaffoldKey,
    this.showBottomNav = false,
    this.centerDocked = false,
    this.showActionIcon = true,
    this.elevation = 4.0,
    this.actionclick,
    this.isWishListRemove = false,
    this.isSearchRemove = false,
    this.isCartRemove = false,
    this.flotingActionButton,


  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
          brightness: Brightness.dark,
          titleSpacing: appTitle != null ? -10 : null,
          title: Container(
            //color: AppTheme.gray_500,
              alignment: Alignment.topLeft,

              // padding: EdgeInsets.only(right: Constant.isUser?0:45),
              child: InkWell(
                onTap: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/MainPage', ModalRoute.withName('/MainPage'));
                },
                child: appTitle == null ? Image.asset(
                  logo_home, fit: BoxFit.contain, height: 40,) : Text(
                  appTitle.toUpperCase(), style: AppTheme.subtitle.copyWith(
                    fontSize: 15,
                    color: AppTheme.black_text,
                    fontWeight: FontWeight.w500),),
              )
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                padding: EdgeInsets.all(0),

                icon: Icon(showDrawer ? Icons.menu : Icons.arrow_back_ios,
                  color: AppTheme.black_text,),

                onPressed: () {
                  if (showDrawer) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    Navigator.pop(context);
                  }
                },
                tooltip: MaterialLocalizations
                    .of(context)
                    .openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: AppTheme.bg,
          shadowColor: AppTheme.white,
          foregroundColor: AppTheme.white,
          elevation: 0,

          actions: <Widget>[


            Visibility(
              visible: !isWishListRemove,
              child: IconButton(
                  tooltip: "My wishlist",

                  icon: Icon(Icons.favorite_border, color: AppTheme.black_text,
                    size: 22,), // Image.asset('assets/images/white_cart.png'),
                  alignment: Alignment.center,

                  onPressed: () {
                    if (ModalRoute
                        .of(context)
                        .settings
                        .name == null || ModalRoute
                        .of(context)
                        .settings
                        .name != UIData.wishListScreen) {

                      Navigator.of(context)
                          .pushNamed('/' + "WishListScreen")
                          ?.then((value) => onFlatButtonPressed());

                      // PageTransition.createRoutedata(
                      //     context, "WishListScreen", null);
                    }
                  }),
            ),


            Visibility(
              visible: !isCartRemove,
              child: (showActionIcon) ? Stack(
                alignment: Alignment.center,


                children: <Widget>[


                  (Constant.count.toString() != "0") ? new Positioned(
                    right: 0,
                    top: 5,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(Constant.count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14,),
                        textAlign: TextAlign.center,),
                    ),
                  ) : SizedBox.shrink(),

                  IconButton(
                      tooltip: "My Cart",

                      icon: Image.asset(
                        'assets/images/action_cart.png', fit: BoxFit.contain,
                        height: 18,),
                      alignment: Alignment.center,

                      onPressed: () {
                        // LogCustom.logd("xxxxxxxx name page :"+ModalRoute.of(context).settings.name);


                        if (ModalRoute
                            .of(context)
                            .settings
                            .name == null || ModalRoute
                            .of(context)
                            .settings
                            .name != UIData.cartScreen) {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),)?.then((value) => onFlatButtonPressed());
                          // Navigator.of(context)
                          //     .pushNamed('/' + "CartScreen")
                          //     ?.then((value) => onFlatButtonPressed());

                          // PageTransition.createRoutedata(
                          //     context, "CartScreen", null);
                        }
                      }),


                ],

              ) : SizedBox.shrink(),
            ),


            Visibility(
              visible: !isSearchRemove,
              child: IconButton(
                  tooltip: "Search",

                  icon: Image.asset(
                    action_search, fit: BoxFit.contain, height: 18,),
                  alignment: Alignment.center,

                  onPressed: () {
                    showSearch(
                        context: context, delegate: SearchDelegateFragment(  onButtonPressed: (){
                          onFlatButtonPressed();
                    },));
                  }),
            ),


          ]


      ),
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      floatingActionButton: flotingActionButton != null
          ? flotingActionButton
          : null,


    );
  }


}
