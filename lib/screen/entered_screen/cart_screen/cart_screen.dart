import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../data/finaldata.dart';
import '../../../data/otherdata/Tool.dart';
import '../../../data/voucherData/Voucher.dart';
import 'ingredient/caculate_total_money.dart';
import 'ingredient/cart_screen_app_bar.dart';
import 'ingredient/item_cart.dart';

class cart_screen extends StatefulWidget {
  final Widget beforeWidget;
  const cart_screen({super.key, required this.beforeWidget});

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  final Voucher voucher = Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', type: 0, perCustom: 0, CustomList: [], maxSale: 0);
  Future<void> _Refresh() async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  height: width/(829/636),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/decor/decor1.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    title: cart_screen_app_bar(beforeWidget: widget.beforeWidget),
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: RefreshIndicator(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                              child: AutoSizeText(
                                finaldata.mainLang.yourcart + finaldata.cartList.length.toString() + ')',
                                style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 100,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                           finaldata.cartList.isNotEmpty ? Container(
                            child: ListView.builder(
                              itemCount: finaldata.cartList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return item_cart(cartdata: finaldata.cartList[index], event: () {setState(() {});},);
                              },
                            ),
                          ) : Container(height: 100, alignment: Alignment.center, child: Text('Your cart is empty', style: TextStyle(fontSize: 13, color: Colors.black,),),),

                          caculate_total_money(voucher: voucher,),
                        ],
                      ),
                      onRefresh: _Refresh,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
        return true;
      },
    );
  }
}
