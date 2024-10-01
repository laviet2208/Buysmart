import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/data/orderData/Order.dart';
import 'package:buysmartm/data/orderData/Receiver.dart';
import 'package:buysmartm/data/otherdata/Tool.dart';
import 'package:buysmartm/data/voucherData/Voucher.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../main_screen/main_screen.dart';
import '../../voucher_page/ingredient/voucher_select/voucher_select.dart';
import '../cart_screen.dart';
import '../check_out/check_out_screen.dart';
import 'cost_text_line.dart';

class caculate_total_money extends StatefulWidget {
  final Voucher voucher;
  const caculate_total_money({super.key, required this.voucher});

  @override
  State<caculate_total_money> createState() => _caculate_total_moneyState();
}

class _caculate_total_moneyState extends State<caculate_total_money> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            cost_text_line(title: 'Items (' + finaldata.cartList.length.toString() + ')', content: getStringNumber(calculatetotalMoney()) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.grey,),

            SizedBox(height: 10,),

            GestureDetector(
              child: cost_text_line(title: 'Voucher', content: (widget.voucher.id == '' ? finaldata.mainLang.selectvoucher : ('- ' + getStringNumber(getVoucherSale(widget.voucher, calculatetotalMoney())) + ' .USDT')), size: width/25, contentColor: Colors.blue, titleColor: Colors.grey,),
              onTap: () {
                if (finaldata.cartList.length == 0) {
                  toastMessage('Your cart is emty');
                } else {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    barrierColor: Colors.white,
                    builder: (context) {
                      return voucher_select(voucher: widget.voucher, ontap: () {
                        setState(() {

                        });
                      }, cost: calculatetotalMoney());
                    },
                  );
                }
              },
            ),

            SizedBox(height: 10,),

            Container(
              height: 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 10,),

            cost_text_line(title: finaldata.mainLang.Subtotal, content: getStringNumber(calculatetotalMoney() - getVoucherSale(widget.voucher, calculatetotalMoney())) + ' .USDT', size: width/25, contentColor: Colors.black, titleColor: Colors.black,),

            SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 243, 175, 74)),
                  ),
                  onPressed: () {
                    if (finaldata.cartList.isNotEmpty) {
                      Order order = Order(id: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', type: 0, perCustom: 0, CustomList: [], maxSale: 0), note: '', productList: [], receiver: Receiver(name: '', nation: '', phoneNumber: '', city: '', district: '', podcode: '', province: '', address: ''), createTime: getCurrentTime(), status: '', owner: '');
                      order.productList = finaldata.cartList;
                      order.voucher = widget.voucher;
                      order.receiver.name = finaldata.account.firstName + ' ' + finaldata.account.lastName;
                      order.receiver.phoneNumber = finaldata.account.phoneNum;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => check_out_screen(order: order, beforewidget: cart_screen(beforeWidget: main_screen()),)),);
                    } else {
                      toastMessage('Your cart is empty');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      finaldata.mainLang.gotocheckout,
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.white,
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
