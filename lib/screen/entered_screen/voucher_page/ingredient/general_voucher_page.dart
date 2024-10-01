import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buysmartm/screen/entered_screen/voucher_page/ingredient/voucher_img_item.dart';
import '../../../../data/voucherData/Voucher.dart';
import '../controller/voucher_page_controller.dart';
import 'voucher_item.dart';

class general_voucher_page extends StatefulWidget {
  const general_voucher_page({super.key});

  @override
  State<general_voucher_page> createState() => _general_voucher_pageState();
}

class _general_voucher_pageState extends State<general_voucher_page> {
  List<Voucher> voucherList = [];
  Future<void> _refresh() async {
    voucherList = await voucher_page_controller.get_voucher_list();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                voucherList.length != 0 ? Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: voucherList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        // child: voucher_item(voucher: voucherList[index]),
                        child: voucher_img_item(voucher: voucherList[index]),
                      );
                    },
                  ),
                ) : Container(
                  height: height - 200,
                  alignment: Alignment.center,
                  child: SpinKitFoldingCube(color: Color.fromARGB(255, 255, 190, 93), size: 30,),
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
