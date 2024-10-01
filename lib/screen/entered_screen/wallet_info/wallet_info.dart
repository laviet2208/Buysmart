import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/screen/entered_screen/wallet_info/ingredient/Deposit_requirements_form/Deposit_requirements_form.dart';
import 'package:buysmartm/screen/entered_screen/wallet_info/ingredient/Withdrawal_requirements_form/Withdrawal_requirements_form.dart';
import 'package:buysmartm/screen/entered_screen/wallet_info/ingredient/card_info.dart';
import 'package:buysmartm/screen/entered_screen/wallet_info/ingredient/change_to_customer_care.dart';
import '../../../../../data/finaldata.dart';
import '../../../data/historyData/Transaction.dart';
import '../../../data/otherdata/Tool.dart';
import '../chat_room/chat_room.dart';
import '../main_screen/main_screen.dart';
import 'controller/wallet_controller.dart';
import 'ingredient/item_history_transaction.dart';
import 'ingredient/text_line_in_profile.dart';
import 'ingredient/wallet_appbar.dart';

class wallet_info extends StatefulWidget {
  const wallet_info({super.key});

  @override
  State<wallet_info> createState() => _wallet_infoState();
}

class _wallet_infoState extends State<wallet_info> {
  bool loading = false;
  List<TransactionHis> hisList = [];

  Future<void> _refresh() async {
    hisList = await wallet_controller.get_his_list();
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
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/decor/decor1.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
                      },
                    ),
                    title: wallet_appbar(),
                  ),
                  body: RefreshIndicator(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ListView(
                          children: [
                            SizedBox(height: 10,),

                            card_info(),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  TextButton(
                                    child: Text(
                                      finaldata.mainLang.Deposit,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'sf',
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 54, 121, 125)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0), // Đặt BorderRadius ở đây
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return change_to_customer_care();
                                        },
                                      );
                                    },
                                  ),

                                  SizedBox(width: 10,),

                                  TextButton(
                                    child: Text(
                                      finaldata.mainLang.Withdraw,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'sf',
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0), // Đặt BorderRadius ở đây
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return change_to_customer_care();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20,),

                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                height: 25,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  finaldata.mainLang.historytransaction,
                                  style: TextStyle(
                                    fontFamily: 'sf',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 100,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: hisList.length,
                                itemBuilder: (context, index) {
                                  return item_history_transaction(his: hisList.reversed.toList()[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onRefresh: _refresh,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
        return true;
      },
    );
  }
}
