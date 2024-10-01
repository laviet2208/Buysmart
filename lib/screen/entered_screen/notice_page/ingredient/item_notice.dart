import 'package:flutter/material.dart';

import '../../../../data/noticeData/noticeData.dart';
import '../../../../data/otherdata/Tool.dart';

class item_notice extends StatelessWidget {
  final noticeData data;
  const item_notice({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              height: 40,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5,
                    left: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 15,
                    right: 0,
                    child: Text(
                      getAllTimeString(data.send),
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'muli',
                          color:Colors.grey,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            height: 6,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 25),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'muli',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Container(
            height: 6,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, right: 60),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                data.sub,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'muli',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),

          Container(
            height: 20,
          )
        ],
      ),
    );
  }
}
