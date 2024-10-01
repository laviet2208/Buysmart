import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/data/otherdata/Tool.dart';

class card_info extends StatefulWidget {
  const card_info({super.key});

  @override
  State<card_info> createState() => _card_infoState();
}

class _card_infoState extends State<card_info> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 41, 46),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -60,
              left: -20,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),

            Positioned(
              bottom: -60,
              right: -60,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(
                    width: 30,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 10,
              bottom: 10,
              left: 25,
              right: 25,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Buy Smart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontFamily: 'logo_font_1',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    height: 27,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      finaldata.account.username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  Expanded(child: Container()),

                  Container(
                    height: 40,
                    child: Row(
                      children: [
                        Container(
                          width: width/4,
                          child: AutoSizeText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            finaldata.account.firstName + '\n' + finaldata.account.lastName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),

                        Expanded(child: Container()),

                        Container(
                          width: width/3,
                          child: AutoSizeText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            finaldata.mainLang.accountbalance + '\n' + getStringNumber(finaldata.account.money) + '.USDT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
