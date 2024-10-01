import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/screen/entered_screen/account_page/account_info_screen/account_info_screen.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/account_info.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/account_page_app_bar.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/bottom_line.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/feature_button.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/language_change.dart';
import 'package:buysmartm/screen/entered_screen/account_page/ingredient/other_box.dart';
import 'package:buysmartm/screen/entered_screen/cart_screen/cart_screen.dart';
import 'package:buysmartm/screen/entered_screen/history_order/history_order_screen.dart';
import 'package:buysmartm/screen/entered_screen/main_screen/main_screen.dart';
import 'package:buysmartm/screen/entered_screen/wallet_info/wallet_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/chatData/chatRoom.dart';
import '../../../data/chatData/messenger.dart';
import '../../before_screen/loading_screen.dart';
import '../../utils/utils.dart';
import '../chat_room/chat_room.dart';

class account_page extends StatefulWidget {
  const account_page({super.key});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  bool loading = false;
  chatRoom room = chatRoom(account: finaldata.account, messengerList: []);
  Future<void> getChatRoom() async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finaldata.account.id).onValue.listen((event) async {
      final dynamic Chatrooms = event.snapshot.value;
      if(Chatrooms != null) {
        room = chatRoom.fromJson(Chatrooms);
        await pushChatRooms(room);
      } else {
        room = chatRoom(account: finaldata.account, messengerList: []);
        room.messengerList.add(messenger(type: 2, content: "Hello, this is Buy Smart's customer service department, how can we help you?"));
        await pushChatRooms(room);
      }
    });
  }

  Future<void> pushChatRooms(chatRoom room) async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finaldata.account.id).set(room.toJson());
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 241, 242),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height/3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 190, 93),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 30,),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: account_page_app_bar(),
                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: account_info(),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: other_box(),
                    ),

                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(height: 20,),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.black, title: finaldata.mainLang.HistoryOrder, iconData: Icons.calendar_today_outlined),
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => history_order_screen()));
                              },
                            )
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.black, title: finaldata.mainLang.YourWallet, iconData: Icons.account_balance_wallet_outlined),
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => wallet_info()));
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.black, title: finaldata.mainLang.accountinfo, iconData: Icons.account_circle_outlined),
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => account_info_screen(),),);
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.black, title: finaldata.mainLang.cart, iconData: Icons.shopping_cart_outlined),
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => cart_screen(beforeWidget: main_screen()),),);
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.indigo, title: finaldata.mainLang.CustomerCare, iconData: Icons.chat_outlined),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      contentPadding: EdgeInsets.all(10),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      content: Container(
                                        width: width - 80,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(height: 15,),

                                            Padding(
                                              padding: EdgeInsets.only(left: 15, right: 15),
                                              child: GestureDetector(
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.blueAccent.withOpacity(0.7)
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.send,
                                                            color: Colors.white,
                                                          ),

                                                          Container(width: 10,),

                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              'Telegram',
                                                              style: TextStyle(
                                                                  fontFamily: 'roboto',
                                                                  color: Colors.white,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  launch("https://t.me/Buysmart_support");
                                                },
                                              ),
                                            ),

                                            Container(height: 15,),

                                            Padding(
                                              padding: EdgeInsets.only(left: 15, right: 15),
                                              child: GestureDetector(
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.yellow.shade600
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          !loading ? Icon(
                                                            Icons.chat_sharp,
                                                            color: Colors.black,
                                                          ) : CircularProgressIndicator(color: Colors.black,strokeWidth: 15,),

                                                          Container(width: 10,),

                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              finaldata.mainLang.support1,
                                                              style: TextStyle(
                                                                  fontFamily: 'roboto',
                                                                  color: Colors.black,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  await getChatRoom();
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => chatRoomScreen(),),);
                                                },
                                              ),
                                            ),

                                            Container(height: 15,),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.black, title: finaldata.mainLang.language, iconData: Icons.language),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return language_change(event: () {setState(() {});});
                                  },
                                );
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.red, title: finaldata.mainLang.signout, iconData: Icons.logout),
                              onTap: () async {
                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                finaldata.account.id = '';
                                finaldata.account.username = '';
                                await _auth.signOut();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                              },
                            ),
                          ),

                          bottom_line(),

                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: GestureDetector(
                              child: feature_button(color: Colors.red, title: finaldata.mainLang.deleteacc, iconData: Icons.delete_outline),
                              onTap: () async {
                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                finaldata.account.id = '';
                                finaldata.account.username = '';
                                await _auth.signOut();
                                toastMessage('Please allow 5-7 days for request processing.');
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loading_screen()), (route) => false,);
                              },
                            ),
                          ),

                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
