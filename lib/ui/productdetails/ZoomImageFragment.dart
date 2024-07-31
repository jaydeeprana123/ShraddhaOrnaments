import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/utils/pager/src/swiper.dart';
import 'package:shradha_design/utils/pager/src/swiper_pagination.dart';

import '../../app_theme.dart';



class ZoomImageData{
final int tap;
final String  name;
final List<String> imageList;

  ZoomImageData(this.tap, this.name,this.imageList);


}


class ZoomImageFragment extends StatefulWidget  {

  final ZoomImageData data;

  const ZoomImageFragment({Key key, @required this.data}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return ZoomImageFragmentState();
  }}


  class ZoomImageFragmentState extends State<ZoomImageFragment>  {


    // List<String> imageList;

     TextEditingController _idController;
     TextEditingController _seekToController;


     int postion;

   //  PhotoViewController _photoViewController;

    @override
  void initState() {
    super.initState();

    postion=widget.data.tap;





    _idController = TextEditingController();
    _seekToController = TextEditingController();


  }



    @override
    Widget build(BuildContext context) {


      return Container(
       // color: AppTheme.bg,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              _getAppBarUI(),

              const Divider(
                height: 1,
              ),


              _buildBannerWidget(widget.data.imageList),


            ],
          ),
        ),
      );
    }


     Widget _getAppBarUI() {
       return Container(
         decoration: BoxDecoration(
           color: AppTheme.primary,
           boxShadow: <BoxShadow>[
             BoxShadow(
                 color: Colors.grey.withOpacity(0.2),
                 offset: const Offset(0, 2),
                 blurRadius: 4.0),
           ],
         ),
         child: Padding(
           padding: EdgeInsets.only(
               top: MediaQuery.of(context).padding.top, left: 8, right: 8),
           child: Row(
             children: <Widget>[
               Container(
                 alignment: Alignment.centerLeft,
                 width: AppBar().preferredSize.height + 40,
                 height: AppBar().preferredSize.height,
                 child: Material(
                   color: Colors.transparent,
                   child: InkWell(
                     borderRadius: const BorderRadius.all(
                       Radius.circular(32.0),
                     ),
                     onTap: () {
                       Navigator.pop(context);
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Icon(Icons.close, color: Colors.white,),
                     ),
                   ),
                 ),
               ),
               Expanded(
                 child: Center(
                   child: Text(
                     widget.data.name,
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 14,
                       color: Colors.white,

                     ),
                     maxLines: 1,
                   ),
                 ),
               ),

               Container(
                 width: AppBar().preferredSize.height + 40,
                 height: AppBar().preferredSize.height,
               )

             ],
           ),
         ),
       );
     }







     bool refreshpossible=false;


    _buildBannerWidget(List<String> imageList) {


      return Expanded(
        //height: SizeConfig.safeBlockVertical*45,
        child: new Stack(
          alignment: AlignmentDirectional.bottomStart,
          fit: StackFit.loose,
          children: <Widget>[

            Swiper(

              itemBuilder: (BuildContext context,int index){

               /* if(!imageList[index].contains("https:")){
                  imageList[index]="https:"+imageList[index];
                }
*/


                return PhotoView(
                  // controller: _photoViewController,
                  imageProvider: NetworkImage(imageList[index],),



                  errorBuilder: (context, error, stackTrace) {


                   /* // LogCustom.logd("xxxxxxx eroor ::"+error.toString());

                    String temp="";


                    if(imageList[index].contains("hires")){

                      String ss= imageList[index].replaceAll("hires", "tch");

                      temp=ss;
                      imageList[index]=ss;

                      refreshpossible=true;

                      //LogCustom.logd("xxxxxxx new url ::"+ss);
                    }

*/
                    //LogCustom.logd("xxxxxxx temp ::"+temp);
                    // LogCustom.logd("xxxxxxx check ::"+error.toString().contains(temp).toString());


                    /*if(!refreshpossible && temp!="" &&error.toString().contains(temp)){
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon(Icons.broken_image,color: AppTheme.gray_500,size: 35,),
                            const SizedBox(
                              width: 8.0,
                            ),

                            Text("Image Not Found",style: AppTheme.subtitle,),

                          ],
                        ),
                      );
                    }
*/


                    return (refreshpossible )?Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Icon(Icons.broken_image,color: AppTheme.gray_500,size: 35,),

                          const SizedBox(
                            width: 8.0,
                          ),

                          Text(refreshpossible?"Image not loaded":"Image Not Found",style: AppTheme.subtitle,),


                          Visibility(
                              visible: refreshpossible,

                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: InkWell(
                                  onTap: (){


                                    refreshpossible=false;

                                    // _photoViewController.reset();

                                    setState(() {

                                    });

                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Icon(Icons.refresh,color: AppTheme.blue,size: 20,),
                                      SizedBox(width: 5,),
                                      Text("Tap to refresh",style: AppTheme.subtitle.copyWith(color: AppTheme.blue,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ),
                              )
                          )



                        ],
                      ),
                    ):Center(child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),);

                  },

                  backgroundDecoration: BoxDecoration(
                    color: Colors.white,

                  ),


                  loadingBuilder: (context, event) {


                    // LogCustom.logd("xxxxxxx loading image ::");

                    if (event == null) {
                      return  Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,

                          children: <Widget>[

                            const Text("Loading"),

                            const SizedBox(height: 10,),

                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),


                          ],
                        ),

                      );
                    }

                    final value = event.cumulativeBytesLoaded /
                        event.expectedTotalBytes;

                    final percentage = (100 * value).floor();
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          Text("$percentage%"),

                          const SizedBox(height: 10,),

                          const  SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),


                        ],
                      ),
                    );


                  },
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                );


              },
              itemCount: imageList.length,
              scale: 0.97,
              //viewportFraction: 0.1,

              autoplay: false,
              loop: false,
              index: postion,


              onIndexChanged: (index){


                postion=index;

                LogCustom.logd("xxxxxxxxxx"+"::"+index.toString());



              },
              pagination: new SwiperPagination(

                  margin: new EdgeInsets.all(10.0),
                  builder: new DotSwiperPaginationBuilder(
                      color: Colors.grey

                  )),

            ),


          ],

        ),

      );



    }





    @override
    void dispose() {
      _idController.dispose();
      _seekToController.dispose();


      super.dispose();
    }





  }