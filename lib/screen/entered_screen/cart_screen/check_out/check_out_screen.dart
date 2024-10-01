import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../data/finaldata.dart';
import '../../../../data/orderData/Order.dart';
import 'ingredient/check_out_app_bar.dart';
import 'ingredient/item_product_in_checkout.dart';
import 'ingredient/total_money_check_out.dart';

class check_out_screen extends StatefulWidget {
  final Order order;
  final Widget beforewidget;
  const check_out_screen({super.key, required this.order, required this.beforewidget});

  @override
  State<check_out_screen> createState() => _check_out_screenState();
}

class _check_out_screenState extends State<check_out_screen> {

  Future<void> _Refresh() async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: check_out_app_bar(),
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
                    'Your order (' + finaldata.cartList.length.toString() + ' items)',
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                child: ListView.builder(
                  itemCount: widget.order.productList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item_product_in_checkout(cartdata: widget.order.productList[index]);
                  },
                ),
              ),

              total_money_check_out(order: widget.order),
            ],
          ),
          onRefresh: _Refresh,
        ),
      ),
    );
  }
}
