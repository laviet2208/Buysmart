import 'package:flutter/material.dart';
import 'package:buysmartm/screen/entered_screen/voucher_page/ingredient/voucher_individual_img_item.dart';

import '../../../../data/finaldata.dart';
import 'voucher_individual_item.dart';

class individual_voucher_page extends StatefulWidget {
  const individual_voucher_page({super.key});

  @override
  State<individual_voucher_page> createState() => _individual_voucher_pageState();
}

class _individual_voucher_pageState extends State<individual_voucher_page> {

  Future<void> _refresh() async {
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              padding: EdgeInsets.only(top: 10),
              children: [
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: finaldata.account.voucherList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: voucher_individual_img_item(voucher: finaldata.account.voucherList[index], event: () { setState(() {}); },),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onRefresh: _refresh,
      ),
    );
  }
}
