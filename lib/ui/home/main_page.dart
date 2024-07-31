import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/interfaceclass/pagechangelistner.dart';
import 'package:shradha_design/ui/categorys/main_categories_screen.dart';
import 'package:shradha_design/ui/home/HomeBloc.dart';
import 'package:shradha_design/ui/home/home_page.dart';
import 'package:shradha_design/ui/profile/profile_screen.dart';
import 'package:shradha_design/ui/search/SearchFragment.dart';
import 'package:shradha_design/ui/widget/common_drawer.dart';
import 'package:shradha_design/utils/page_transition.dart';
import 'package:shradha_design/utils/uidata.dart';
import 'package:shradha_design/utils/cart_db.dart' as cart_database;
import 'package:shradha_design/utils/utils.dart';
import '../../app_theme.dart';
import '../../utils/my_icons.dart';
import 'package:need_resume/need_resume.dart';

import 'home_page_with_category.dart';




class MainPage extends StatefulWidget {
  final appTitle;
   Widget bodyData;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showActionIcon;
  Function actionclick;
  final Widget flotingActionButton;


  MainPage({this.appTitle,
    this.bodyData,
    this.showDrawer = true,
    this.backGroundColor,
    this.actionFirstIcon = Icons.search,
    this.scaffoldKey,
    this.showActionIcon = true,
    this.actionclick,
    this.flotingActionButton

  });


  @override
  MainPageState createState() {
    return MainPageState();
  }

}



  class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin  implements PageStateCallBack{
    bool isChildButtonPressed = false;
    int _selectedIndex = 0;

    TabController _tabController;

    HomeBloc _bloc ;//= HomeBloc();

    @override
    pageChange(int posion) {


      print("Selected  call back Index: " + posion.toString());


      if(_tabController!=null){

        _tabController.index=posion;


        if(_tabController.index!=2 ){
          setState(() {
            _selectedIndex = _tabController.index;
          //  showSearch( context: context, delegate: SearchDelegateFragment());
          });

        }else if(_tabController.index!=3){

          setState(() {
            _selectedIndex = _tabController.index;
          });


        }
        else{
          setState(() {
            _tabController.index=_selectedIndex;
          });

        }



      }




    }




    @override
  void initState() {




      checkCount();

      _bloc = HomeBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );

      super.initState();


    _tabController = TabController(vsync: this, length: 5);


    _tabController.addListener(() {

    //  print("Selected Index: " + _tabController.index.toString());
    //  print("Selected Index: _selectedIndex: " + _selectedIndex.toString());


      if(_tabController.index!=2 ){
        setState(() {
          _selectedIndex = _tabController.index;
         // showSearch( context: context, delegate: SearchDelegateFragment());

        });


      }else if(_tabController.index!=3){

        setState(() {
          _selectedIndex = _tabController.index;
        });


      }
      else{
        setState(() {
          _tabController.index=_selectedIndex;
        });

      }


    });


    }





    checkCount()async{

      final database = cart_database.openDB();
      List<CartConstants> db=await cart_database.cart(database);

      if(Constant.count!=db.length){
        setState(() {
          Constant.count=db.length;
        });
      }


    }



    @override
  Widget build(BuildContext context) {


      return  WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
          backgroundColor: AppTheme.bg,
          appBar:  AppBar(
          titleSpacing: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              title: Container(
                alignment: Alignment.centerLeft,
                child:_selectedIndex == 0?Image.asset(logo_original,fit: BoxFit.contain,height:  30,):Text(_selectedIndex == 1?"Categories".toUpperCase():_selectedIndex == 4?"Profile".toUpperCase():"",style: AppTheme.subtitle.copyWith(
                    fontSize: 15,
                    color: AppTheme.black_text,
                    fontWeight: FontWeight.w500),),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(

                    icon: Icon(widget.showDrawer?Icons.menu:Icons.arrow_back_ios,color: AppTheme.black,),

                    onPressed: () {
                      if(widget.showDrawer){
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

                    icon:Icon(Icons.favorite_border,color: AppTheme.black_text,size: 22,) ,// Image.asset('assets/images/white_cart.png'),
                    alignment: Alignment.center,

                    onPressed: () {

                      if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!=UIData.wishListScreen){


                        Navigator.of(context).pushNamed('/'+"WishListScreen")?.then((value) {

                          checkCount();
                          setState(() {

                          });
                          print("ayooo");
                        } );



                        // PageTransition.createRoutedata(context,"WishListScreen",null);

                      }



                    }),

                (widget.showActionIcon )? Stack(
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
                        child: Text( Constant.count.toString(), style: TextStyle(color: Colors.white,fontSize: 14,), textAlign: TextAlign.center,    ),
                      ),
                    ) : SizedBox.shrink(),

                    IconButton(
                        tooltip: "My Cart",
                        icon: Image.asset('assets/images/action_cart.png',fit:  BoxFit.contain,height: 18),

                       // icon:Icon(Icons.shopping_cart_outlined,color: AppTheme.black,) ,// Image.asset('assets/images/white_cart.png'),
                        alignment: Alignment.center,

                        onPressed: () {

                          if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!=UIData.cartScreen){
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);


                            Navigator.of(context).pushNamed('/'+"CartScreen")?.then((value) {

                              checkCount();
                              setState(() {

                              });
                              print("ayooo");
                            } );

                            // PageTransition.createRoutedata(context,"CartScreen",null);

                          }
                        }),


                  ],

                ) :SizedBox.shrink(),

                IconButton(
                    tooltip: "Search",

                    icon: Image.asset(action_search,fit:  BoxFit.contain,height: 18,),
                    //icon:Icon(Icons.search,color: AppTheme.black,) ,// Image.asset('assets/images/white_cart.png'),
                    alignment: Alignment.center,

                    onPressed: () {

                      showSearch( context: context, delegate: SearchDelegateFragment(  onButtonPressed: (){
                        setState(() {

                        });
                      },));


                    }),


              ]

          ),
          drawer: widget.showDrawer ? CommonDrawer(callBack: this,) : null,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,

            children: <Widget>[
              HomePageFragment(onFlatButtonPressed: (){
                setState(() {

                });
              }),
              HomePageWithCategories(onFlatButtonPressed: (){
                setState(() {

                });
              }),
              SizedBox.shrink(),
              SizedBox.shrink(),

              ProfileScreen(),

            ],
          ),

          //widget.bodyData,
          floatingActionButton:widget.flotingActionButton != null ? widget.flotingActionButton : null,


          bottomNavigationBar: BottomAppBar(


            child: Container(
             // color: AppTheme.white,
              child: TabBar(
                onTap: (index) {
                  // Should not used it as it only called when tab options are clicked,
                  // not when user swapped
                },
               // indicator: BoxDecoration(color: Colors.redAccent.withOpacity(0.2)),
                tabs: <Widget>[
                  Icon(Icons.home_outlined,color: AppTheme.black_text,),
                  Icon(Icons.category_outlined,color: AppTheme.black_text,),

                  InkWell(
                    onTap: (){


                      Utils.launchWhatsApp(phone: "+919898073314"/*_bloc.apiProvider.pref.getContactPhone()*/);


                    },
                    child: Container(
                      // color: AppTheme.blue,
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.only(top: 4),
                      child:  Image.asset('assets/images/tab_whats.png',height: 20,),

                    ),
                  ),


                  InkWell(
                    onTap: (){

                      showSearch( context: context, delegate: SearchDelegateFragment(  onButtonPressed: (){
                        setState(() {

                        });
                      },));
                    },
                    child: Container(
                      // color: AppTheme.blue,
                      height: 40,
                      width: 500,
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(Icons.search,color: AppTheme.black_text,),

                    ),
                  ),



                  Icon(Icons.person_outline_rounded,color: AppTheme.black_text,),



                ],
                controller: _tabController,
              ),
            ),
          ),

          /*bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(Icons.home),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Camera',
          ),

          BottomNavigationBarItem(

            icon: ImageIcon(
              AssetImage("assets/images/category.png"),
              color: Color(0xFF3A5A98),
            ),
            label: 'Camera',
          ),




          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Chats',
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Chats',
          ),


        ],

        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        backgroundColor: AppTheme.white,
        selectedItemColor: AppTheme.black,
        unselectedItemColor: AppTheme.gray_500,
        showSelectedLabels: false,
        showUnselectedLabels: false,


      ),
*/

        )
      );





  }








  void _onItemTapped(int index) {


   if(index==0){
     widget.bodyData=HomePageFragment();
   }else if(index==1){
     widget.bodyData=HomePageWithCategories();
   }else if(index==2){
     widget.bodyData=HomePageWithCategories();
   }else if(index==3){
     widget.bodyData=ProfileScreen();
   }else if(index==4){
     widget.bodyData=HomePageWithCategories();
   }

    setState(() {
      _selectedIndex = index;
    });




  }



    Future<bool> _onWillPop() async {

      return (await showDialog(
        context: context,
        builder: (context) => new CupertinoAlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No',  style: AppTheme.subtitlequicksand.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.black_text)),
            ),
            new TextButton(
              onPressed: ()  {

                SystemChannels.platform.invokeMethod('SystemNavigator.pop');

              },
              child: new Text('Yes' ,style: AppTheme.subtitlequicksand.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppTheme.black_text)),
            ),
          ],
        ),
      )) ?? false;
    }





    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }





}
