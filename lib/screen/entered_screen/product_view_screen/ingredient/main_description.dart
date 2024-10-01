import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class main_description extends StatelessWidget {
  final String description;
  const main_description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'About this item',
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width/17,
                ),
              ),
            ),

            SizedBox(height: 5,),

            Container(
              child: HtmlWidget(
                description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
