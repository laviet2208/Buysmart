import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/screen/utils/utils.dart';
import '../../../../data/finaldata.dart';
import '../../../../data/orderData/Order.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../cart_screen/ingredient/cost_text_line.dart';
import 'view_product_list.dart';

class his_order_item extends StatefulWidget {
  final Order order;
  const his_order_item({super.key, required this.order});

  @override
  State<his_order_item> createState() => _his_order_itemState();
}

class _his_order_itemState extends State<his_order_item> {
  String status = '';
  Color statusColor = Colors.white;

  void get_status() {
    if (widget.order.status == 'A') {
      status = finaldata.mainLang.Theorderhasnotbeenprocessedyet;
      statusColor = Colors.orange;
    }

    if (widget.order.status == 'B') {
      status = finaldata.mainLang.Orderisbeingprocessed;
      statusColor = Colors.orange;
    }

    if (widget.order.status == 'C') {
      status = finaldata.mainLang.Orderhasbeencompleted;
      statusColor = Colors.blueAccent;
    }

    if (widget.order.status == 'D') {
      status = finaldata.mainLang.Theorderhasbeencancelled;
      statusColor = Colors.red;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_status();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.order.id,
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: width/25,
                color: Colors.black,
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              getAllTimeString(widget.order.createTime),
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: width/30,
                color: Colors.grey,
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              status,
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: width/30,
                color: statusColor,
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              finaldata.mainLang.paymentinformation,
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: width/30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 4,),

          cost_text_line(title: 'Items (' + widget.order.productList.length.toString() + ')', content: getStringNumber(calculatetotalOrderMoney(widget.order)) + ' .usd', size: width/30, contentColor: Colors.black, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          cost_text_line(title: 'Voucher', content: (widget.order.voucher.id == '' ? "Do not select voucher" : ('- ' + getStringNumber(getVoucherSale(widget.order.voucher, calculatetotalMoney())) + ' .usd')), size: width/30, contentColor: Colors.blue, titleColor: Colors.grey,),

          SizedBox(height: 4,),

          cost_text_line(title: finaldata.mainLang.Subtotal, content: getStringNumber(calculatetotalOrderMoney(widget.order) - getVoucherSale(widget.order.voucher, calculatetotalMoney())) + ' .usd', size: width/25, contentColor: Colors.black, titleColor: Colors.black,),

          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return view_product_list(order: widget.order);
                },
              );
            },
            child: Text(
              finaldata.mainLang.viewproductlist,
              style: TextStyle(
                fontFamily: 'muli',
                color: Colors.blue,
                fontSize: width/25,
              ),
            ),
          ),

          (widget.order.status == 'A' || widget.order.status == 'B') ? TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Cancel Order'),
                    content: Text('Are you sure you want to cancel this order?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('No', style: TextStyle(color: Colors.blue),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Yes', style: TextStyle(color: Colors.red),),
                        onPressed: () async {
                          DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
                          await databaseRef.child('Order').child(widget.order.id).child('status').set('D');
                          toastMessage('Cancel success');
                          widget.order.status = 'D';
                          setState(() {
                            get_status();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Cancel this order',
              style: TextStyle(
                fontFamily: 'muli',
                color: Colors.redAccent,
                fontSize: width/25,
              ),
            ),
          ) : Container(height: 0,),

          Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Container(
              height: 1,
              decoration: BoxDecoration(color: Colors.grey,),
            ),
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
