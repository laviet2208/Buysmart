import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';
import '../../cart_screen/cart_screen.dart';
import '../../main_screen/main_screen.dart';

class product_view_appbar extends StatelessWidget {
  final String title;
  final Widget widget;
  final Widget currentWidget;
  const product_view_appbar({super.key, required this.title, required this.widget, required this.currentWidget});

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
            right: 90,
            child: Row(
              children: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Container(
                      width: 30,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.chevron_left,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget));
                  },
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Container(
                      child: AutoSizeText(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 100,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    child: GestureDetector(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => cart_screen(beforeWidget: currentWidget)),);
                      },
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
