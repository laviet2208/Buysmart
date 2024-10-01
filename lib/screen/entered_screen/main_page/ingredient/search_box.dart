import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';

class search_box extends StatelessWidget {
  const search_box({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width - 20,
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
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
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    finaldata.mainLang.SearchproductsinBuySmart,
                    style: TextStyle(
                      fontFamily: 'sf',
                      color: Colors.grey,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 10,),

          Container(
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
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
            child: Center(
              child: Icon(
                Icons.search,
                color: Color.fromARGB(255, 49, 127, 123),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
