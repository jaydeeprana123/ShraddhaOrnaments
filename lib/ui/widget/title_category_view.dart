import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';
import '../../constant/constant.dart';
import '../../response/categoryproductlist/product_list_response.dart';
import '../../response/maincategory/main_category_response.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_icons.dart';
import '../../utils/utils.dart';
import '../categorys/sub_categories_screen.dart';
import 'loader.dart';

class TitleCategoryView extends StatelessWidget {
  final double width;
  final double height;
  final CategoryData categoryData;

  const TitleCategoryView({this.width, this.height, this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadowColor: AppTheme.light_primarydark,

        child: Container(

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.all(5),


                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(6),topLeft: Radius.circular(6)),
                    // padding: EdgeInsets.all(4),
                    child: CachedNetworkImage(
                      imageUrl: categoryData.image,

                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => Image.asset(
                        logo_pink,
                        width: double.infinity,
                        color: AppTheme.off_White,
                        fit: BoxFit.cover,
                      ),
                      placeholder: (context, url) => Image.asset(
                        logo_pink,
                        width: double.infinity,
                        color: AppTheme.off_White,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  //color: AppTheme.primarydark,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 8,left: 8, right: 8, bottom: 8),
                  width: double.infinity,
                  child:

    RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: [
    TextSpan(
    style: AppTheme.subtitlequicksand.copyWith(
    fontSize: 12,
    color: AppTheme.primarydark,
    fontWeight: FontWeight.w400),
    text: categoryData.title),

    ]))

                  // Text(
                  //   categoryData.title,
                  //   style: AppTheme.subtitlequicksand.copyWith(
                  //       fontSize: 10,
                  //       color: AppTheme.primarydark,
                  //       fontWeight: FontWeight.w400),
                  //   textAlign: TextAlign.center,
                  //   maxLines: 2,
                  // ),
                ),
              ]),
        ),
      ),
    );
  }
}
