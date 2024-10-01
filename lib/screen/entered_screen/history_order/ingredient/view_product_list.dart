import 'package:flutter/material.dart';
import '../../../../data/orderData/Order.dart';
import 'item_product_in_his.dart';

class view_product_list extends StatefulWidget {
  final Order order;
  const view_product_list({super.key, required this.order});

  @override
  State<view_product_list> createState() => _view_product_listState();
}

class _view_product_listState extends State<view_product_list> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(top: 10, bottom: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      title: Text(widget.order.id, style: TextStyle(fontSize: width/20),),
      content: Container(
        width: width,
        height: height/2,
        child: ListView.builder(
          itemCount: widget.order.productList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return item_product_in_his(cartdata: widget.order.productList[index]);
          },
        ),
      ),
    );
  }
}
