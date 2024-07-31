import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';
import '../../constant/constant.dart';
import '../../response/categoryproductlist/product_list_response.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_icons.dart';
import '../../utils/utils.dart';
import 'loader.dart';

class TitleGridView extends StatelessWidget {
  final double width;
  final double height;
  final ProductData productData;

  const TitleGridView({this.width, this.height, this.productData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 190,
          margin: EdgeInsets.only(right: 16),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppTheme.white,
            border: Border.all(
              color: AppTheme.light_grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(2.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.gray_300,
                offset: const Offset(0, 4),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(children: <Widget>[
            // Image.asset('assets/images/logo.png',height: 100),

            CachedNetworkImage(
              imageUrl: productData.imageName,
              fit: BoxFit.cover,
              width: 180,
              height: 185,
              errorWidget: (context, url, error) => Image.asset(
                  'assets/images/no_image.jpg',
                  width: 180,
                  height: 185),
              placeholder: (context, url) => Image.asset(
                  'assets/images/loading_dots.gif',
                  width: 180,
                  height: 185),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              "\₹" + Utils.currencyText(productData.price),
                              style: AppTheme.subtitleopensanssemibold.copyWith(
                                  fontSize: 13,
                                  color: AppTheme.black_grey,
                                  fontWeight: FontWeight.w800))),
                      InkWell(
                        onTap: () {
                          if (productData.wishlist == Constant.isWishlist) {
                            productData.wishlist = "0";
                           // addremoveWishlist(false, productData.id.toString());
                          } else {
                            productData.wishlist = "1";
                           // addremoveWishlist(true, productData.id.toString());
                          }
                        },
                        child: SvgPicture.asset(
                          (productData.wishlist == Constant.isWishlist)
                              ? favourite
                              : favourite,
                          height: 18,
                          color: (productData.wishlist == Constant.isWishlist)
                              ? AppTheme.primary
                              : AppTheme.light_grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    productData.title,
                    style: AppTheme.subtitleopensans.copyWith(
                        fontSize: 13,
                        color: AppTheme.black_grey,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            style: TextStyle(
                                color: black_354356,
                                fontFamily: AppTheme.poppinsRegular,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                height: 1.2),
                            text: "Code : "),
                        TextSpan(
                            style: TextStyle(
                                color: AppTheme.primarydark,
                                fontFamily: AppTheme.poppinsRegular,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                height: 1.5),
                            text: productData.productCode)
                      ]))
                ],
              ),
            ),
          ]),
        ),
        (productData.tna == "1")
            ? Positioned(
                left: 5,
                top: 2,
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/tna_icon.png',
                    height: 25,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }


  addremoveWishlist(bool isAdd,String productId,String userId, BuildContext context)async{

    await Pr.show(context);

    Map<String, String> parms = new Map<String,String>();
    parms.putIfAbsent("user_id",()=> userId);
    parms.putIfAbsent("product_id",()=> productId);

    // await _bloc.addremoveWhislist(isAdd,parms);
    //
    // await Pr.hide(context);
    //
    // setState(() {});

  }


}

