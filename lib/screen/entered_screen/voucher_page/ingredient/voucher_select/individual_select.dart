import 'package:flutter/material.dart';
import '../../../../../data/finaldata.dart';
import '../../../../../data/voucherData/Voucher.dart';
import 'item_voucher_select.dart';

class individual_select extends StatefulWidget {
  final Voucher voucher;
  final double cost;
  final VoidCallback ontap;
  const individual_select({super.key, required this.voucher, required this.cost, required this.ontap});

  @override
  State<individual_select> createState() => _individual_selectState();
}

class _individual_selectState extends State<individual_select> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Container(
              height: height/2-40,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: finaldata.account.voucherList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: item_voucher_select(voucher: finaldata.account.voucherList[index], event: () {
                      widget.voucher.Setdata(finaldata.account.voucherList[index]);
                      widget.ontap();
                      Navigator.of(context).pop();
                    },
                    ),
                  );
                },
              )
          ),
        ),
      ),
    );  }
}
