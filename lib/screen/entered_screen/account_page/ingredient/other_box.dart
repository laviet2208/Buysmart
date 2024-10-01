import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';

class other_box extends StatelessWidget {
  const other_box({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = 100;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Container(
          child: Row(
            children: [
              Container(
                width: (width - 20)/3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          (finaldata.account.createTime.month > 9 ? finaldata.account.createTime.month.toString() : '0' + finaldata.account.createTime.month.toString()) + '/' + finaldata.account.createTime.year.toString(),
                          style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      height: 20,
                      alignment: Alignment.bottomCenter,
                      child: AutoSizeText(
                        finaldata.mainLang.createtime,
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: (width - 20)/3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          finaldata.account.voucherList.length.toString(),
                          style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      height: 20,
                      alignment: Alignment.bottomCenter,
                      child: AutoSizeText(
                        finaldata.mainLang.yourvoucher,
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            finaldata.cartList.length.toString(),
                            style: TextStyle(
                              fontFamily: 'sf',
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        height: 20,
                        alignment: Alignment.bottomCenter,
                        child: AutoSizeText(
                          finaldata.mainLang.cart,
                          style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
