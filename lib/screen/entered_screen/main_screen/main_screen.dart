import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/screen/entered_screen/account_page/account_page.dart';
import 'package:buysmartm/screen/entered_screen/main_page/main_page.dart';
import 'package:buysmartm/screen/entered_screen/notice_page/notice_page.dart';
import 'package:buysmartm/screen/entered_screen/search_page/search_page.dart';
import 'package:buysmartm/screen/entered_screen/voucher_page/voucher_page.dart';

import '../../../data/Account/Account.dart';
import '../../../data/finaldata.dart';
import '../search_page/controller/controller.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  Widget getBody(int index) {
    if (index == 0) {
      return main_page(event: () {setState(() {});},);
    }
    if (index == 1) {
      return account_page();
    }
    if (index == 2) {
      return search_page();
    }
    if (index == 3) {
      return notice_page();
    }
    if (index == 4) {
      return voucher_page();
    }
    return Container();
  }

  void get_account_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Account").child(finaldata.account.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      finaldata.account = Account.fromJson(data);
    });
  }

  Future<void> get_all_product() async {
    if (finaldata.productList.length == 0) {
      finaldata.productList = await search_page_controller.get_product_list();
      print('Số lượng: ' + finaldata.productList.length.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_account_data();
    get_all_product();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 241, 242),
        body: getBody(finaldata.currentPage),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Color.fromARGB(255, 255, 190, 93).withOpacity(0.2),
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'muli',
                  ),
                ),
                backgroundColor: Colors.transparent,
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              ),
              child: NavigationBar(
                height: 70,
                selectedIndex: finaldata.currentPage,
                onDestinationSelected: (selectedPage) => setState(() {
                  finaldata.currentPage = selectedPage;
                }),
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home_outlined, color: finaldata.currentPage == 0 ? Colors.black : Colors.black, size: 22,), label: finaldata.mainLang.home,),
                  NavigationDestination(icon: Icon(Icons.account_circle_outlined, color: finaldata.currentPage == 1 ? Colors.black : Colors.black, size: 22,), label: finaldata.mainLang.account,),
                  NavigationDestination(icon: Icon(Icons.search, color: finaldata.currentPage == 2 ? Colors.black : Colors.black, size: 22,), label: finaldata.mainLang.search,),
                  NavigationDestination(icon: Icon(Icons.notifications_none, color: finaldata.currentPage == 3 ? Colors.black : Colors.black, size: 22,), label: finaldata.mainLang.notice,),
                  NavigationDestination(icon: Icon(Icons.discount_outlined), label: finaldata.mainLang.voucher,),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
