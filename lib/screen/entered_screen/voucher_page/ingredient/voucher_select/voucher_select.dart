import 'package:flutter/material.dart';
import '../../../../../data/finaldata.dart';
import '../../../../../data/voucherData/Voucher.dart';
import 'general_select.dart';
import 'individual_select.dart';

class voucher_select extends StatefulWidget {
  final Voucher voucher;
  final double cost;
  final VoidCallback ontap;
  const voucher_select({super.key, required this.voucher, required this.cost, required this.ontap});

  @override
  State<voucher_select> createState() => _voucher_selectState();
}

class _voucher_selectState extends State<voucher_select>  with SingleTickerProviderStateMixin {
  int indexTab = 0;
  late TabController _tabController;

  Widget getwidget() {
    if (indexTab == 0) {
      return general_select(voucher: widget.voucher, cost: widget.cost, ontap: widget.ontap);
    }
    return individual_select(voucher: widget.voucher, cost: widget.cost, ontap: widget.ontap);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        // height: height/2,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Uncheck voucher',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent
                        ),
                      ),
                      onTap: () {
                        widget.voucher.changeToDefault();
                        widget.ontap();
                        Navigator.of(context).pop();
                      },
                    ),

                    Container(width: 20,),

                    GestureDetector(
                      child: Text(
                        'Close   ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: SizedBox.shrink(),
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        indicatorColor: Colors.transparent,
                        onTap: (index) {
                          setState(() {
                            indexTab = index;
                          });
                        },
                        dividerColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(fontFamily: 'muli', fontWeight: FontWeight.bold), // TextStyle của văn bản khi được chọn
                        padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 5),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey.withOpacity(0.2),
                        ),
                        tabs: [
                          Tab(text: finaldata.mainLang.GeneralVoucher),
                          Tab(text: finaldata.mainLang.IndividualVoucher),
                        ],
                      ),
                    ],

                  ),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: getwidget(),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
