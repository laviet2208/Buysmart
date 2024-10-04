import 'package:buysmartm/data/product/Product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../data/otherdata/Tool.dart';
import '../../../../product_view_screen/product_view_screen.dart';
import 'add_to_cart_button.dart';

class item_product_loading extends StatefulWidget {
  const item_product_loading({super.key,});

  @override
  State<item_product_loading> createState() => _item_product_loadingState();
}

class _item_product_loadingState extends State<item_product_loading> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60)/2;
    double height = width * 1.5;
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              child: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.white,
                enabled: true,
                child: Container(
                  width: width - 10,
                  height: width - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
              ),
            ),

            Positioned(
                top: 8 + width - 10,
                left: 5,
                right: 5,
                bottom: 0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      enabled: true,
                      child: Container(
                        width: width - 10,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.04),
                        ),
                      ),
                    ),

                    SizedBox(height: 3,),

                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      enabled: true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 0, right: 50),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.04),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 3,),

                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      enabled: true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 0, right: 20),
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.04),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
