import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';

class notice_page_appbar extends StatelessWidget {
  const notice_page_appbar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 55,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            bottom: 10,
            left: 0,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                    width: 30,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.notifications_active_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Container(
                  width: (width - 40)/2,
                  child: AutoSizeText(
                    "Notice",
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: (width - 40)/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      width: 35,
                    ),
                  ),

                  SizedBox(width: 10,),

                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: finaldata.avatarUrl == '' ? Image.asset('assets/image/product_type_example/ava_example.png', fit: BoxFit.cover,) :
                        Image.network(finaldata.avatarUrl, fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
