import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/finaldata.dart';
import '../../chat_room/chat_room.dart';

class change_to_customer_care extends StatefulWidget {
  const change_to_customer_care({super.key});

  @override
  State<change_to_customer_care> createState() => _change_to_customer_careState();
}

class _change_to_customer_careState extends State<change_to_customer_care> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width - 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  finaldata.mainLang.transacSub,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: width/30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli',
                  ),
                ),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => chatRoomScreen(),),);
                },
              ),
            ),

            Container(height: 15,),
          ],
        ),
      ),
    );
  }
}
