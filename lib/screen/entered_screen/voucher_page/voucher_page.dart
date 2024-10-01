import 'package:flutter/material.dart';

import '../../../data/finaldata.dart';
import 'ingredient/general_voucher_page.dart';
import 'ingredient/individual_voucher_page.dart';
import 'ingredient/voucher_app_bar.dart';

class voucher_page extends StatefulWidget {
  const voucher_page({super.key});

  @override
  State<voucher_page> createState() => _voucher_pageState();
}

class _voucher_pageState extends State<voucher_page> with SingleTickerProviderStateMixin {
  int indexTab = 0;
  late TabController _tabController;

  Widget getwidget() {
    if (indexTab == 0) {
      return general_voucher_page();
    }
    return individual_voucher_page();
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
    return Scaffold(
      body: Scaffold(
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
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: voucher_app_bar(),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
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
                            dividerColor: Colors.transparent,
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
                    body: getwidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
