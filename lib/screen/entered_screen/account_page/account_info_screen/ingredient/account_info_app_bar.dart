import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../data/finaldata.dart';
import '../../../main_screen/main_screen.dart';

class account_info_app_bar extends StatelessWidget {
  const account_info_app_bar({super.key});

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
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Container(
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.chevron_left,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
                  },
                ),

                SizedBox(width: 10,),

                Container(
                  width: (width - 40)/2,
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: AutoSizeText(
                    "Your account",
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
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(5),
                      //   color: Colors.white.withOpacity(0.3),
                      // ),
                      // child: Padding(
                      //   padding: EdgeInsets.all(0),
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     child: Icon(
                      //       Icons.shopping_cart_outlined,
                      //       color: Colors.black,
                      //       size: 20,
                      //     ),
                      //   ),
                      // ),
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
