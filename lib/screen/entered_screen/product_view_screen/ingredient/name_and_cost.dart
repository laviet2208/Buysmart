import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../data/product/Product.dart';
import 'type_info.dart';

class name_and_cost extends StatelessWidget {
  final Product product;
  const name_and_cost({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width/20,
                ),
              ),
            ),

            SizedBox(height: 10,),

            type_info(id: product.productType),

            SizedBox(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                getStringNumber(product.cost) + ' .USDT',
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width/17,
                ),
              ),
            ),

            SizedBox(height: 5,),

            (product.cost != 0 && product.costBeforeSale != 0) ? Container(
              alignment: Alignment.centerLeft,
              child: Text(
                finaldata.mainLang.OriginalPrice + getStringNumber(product.costBeforeSale) + finaldata.mainLang.usdyouwillsave + calculateDiscountPercentage(product.costBeforeSale, product.cost).toString() + '%',
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: width/30,
                ),
              ),
            ) : Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'You will save maximum when purchasing',
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: width/30,
                ),
              ),
            ),

            SizedBox(height: 5,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                finaldata.mainLang.Thisisbestofferforyou,
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: width/30,
                ),
              ),
            ),

            SizedBox(height: 5,),

            product.costBeforeSale > product.cost ? Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: finaldata.mainLang.salelimit,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width / 30,
                          fontFamily: 'muli',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: getDayTimeString(product.saleLimit),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width / 30,
                          fontFamily: 'muli',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                ),
              ),
            ) : Container(height: 0,),
          ],
        ),
      ),
    );
  }
}
