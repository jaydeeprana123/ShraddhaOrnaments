import 'package:flutter/material.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/ui/widget/common_drawer.dart';
import 'package:shradha_design/utils/page_transition.dart';
import '../../app_theme.dart';
import '../../utils/my_icons.dart';




class CommonScaffold extends StatelessWidget {
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
   Function actionclick;
  final Widget flotingActionButton;


  CommonScaffold(
      {this.appTitle,
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
        this.actionclick ,
        this.flotingActionButton

      });


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: AppTheme.bg,
      appBar:  AppBar(
        brightness: Brightness.dark,

        title: Container(
          alignment: Alignment.topLeft,

         // padding: EdgeInsets.only(right: Constant.isUser?0:45),
          child: Image.asset(logo_home,fit:  BoxFit.contain,height: 30,),
        ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(

                icon:   Icon(showDrawer?Icons.menu:Icons.arrow_back_ios,color: AppTheme.black,),

                onPressed: () {
                  if(showDrawer){
                    Scaffold.of(context).openDrawer();
                  }else{
                    Navigator.pop(context);
                  }

                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: AppTheme.bg,
         shadowColor: AppTheme.white,
         foregroundColor: AppTheme.white,
         elevation: 0,

         actions: <Widget>[



           IconButton(
               tooltip: "My wishlist",

               icon:Icon(Icons.favorite_border,color: AppTheme.black,) ,// Image.asset('assets/images/white_cart.png'),
               alignment: Alignment.center,

               onPressed: () {



                 if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="CartScreen"){
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);

                   // PageTransition.createRoutedata(context,"CartScreen",null);

                 }
               }),





           (showActionIcon )? Stack(
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
                     minWidth: 22,
                     minHeight: 22,
                   ),
                   child: Text( Constant.count.toString(), style: TextStyle(color: Colors.white,fontSize: 13,), textAlign: TextAlign.center,    ),
                 ),
               ) : SizedBox.shrink(),

               IconButton(
                   tooltip: "My Cart",

                   icon:Icon(Icons.shopping_cart_outlined,color: AppTheme.black,) ,// Image.asset('assets/images/white_cart.png'),
                   alignment: Alignment.center,

                   onPressed: () {



                     if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="CartScreen"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);

                       PageTransition.createRoutedata(context,"CartScreen",null);

                     }
                   }),


             ],

           ) :SizedBox.shrink(),





           IconButton(
               tooltip: "Search",

               icon:Icon(Icons.search,color: AppTheme.black,) ,// Image.asset('assets/images/white_cart.png'),
               alignment: Alignment.center,

               onPressed: () {



                 if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!="CartScreen"){
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);

                   // PageTransition.createRoutedata(context,"CartScreen",null);

                 }
               }),







         ]



      ),
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      floatingActionButton:flotingActionButton != null ? flotingActionButton : null,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),


    );



  }





}
