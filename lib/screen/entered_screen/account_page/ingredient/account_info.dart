import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';

class account_info extends StatelessWidget {
  const account_info({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: width - 40,
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1000),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: finaldata.avatarUrl == '' ? Image.asset('assets/image/product_type_example/ava_example.png', fit: BoxFit.cover,) :
                Image.network(finaldata.avatarUrl, fit: BoxFit.cover,),
              ),
            ),
          ),

          SizedBox(width: 10,),

          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      finaldata.account.lastName + ' ' + finaldata.account.firstName,
                      style: TextStyle(
                        fontFamily: 'sf',
                        color: Colors.black,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    height: 19,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Normal account',
                      style: TextStyle(
                        fontFamily: 'sf',
                        color: Colors.black,
                        fontSize: 100,
                        fontWeight: FontWeight.normal,
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
