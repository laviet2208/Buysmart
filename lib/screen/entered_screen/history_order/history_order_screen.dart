import 'package:flutter/material.dart';

import '../../../data/orderData/Order.dart';
import '../main_screen/main_screen.dart';
import 'controller/history_order_controller.dart';
import 'ingredient/his_order_appbar.dart';
import 'ingredient/his_order_item.dart';
class history_order_screen extends StatefulWidget {
  const history_order_screen({super.key});

  @override
  State<history_order_screen> createState() => _history_order_screenState();
}

class _history_order_screenState extends State<history_order_screen> {
  List<Order> orderList = [];

  Future<void> _refresh() async {
    orderList = await history_order_controller.get_order_list();
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
                right: 0,
                bottom: 0,
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
                    title: his_order_appbar(),
                  ),
                  body: RefreshIndicator(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: orderList.length != 0 ? ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(height: 10,),

                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: orderList.length,
                                itemBuilder: (context, index) {
                                  return his_order_item(order: orderList.reversed.toList()[index]);
                                },
                              ),
                            ),
                          ],
                        ) : Text('There are no orders here!', style: TextStyle(fontSize: 14,color: Colors.black),),
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
