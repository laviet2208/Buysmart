import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class feature_button extends StatelessWidget {
  final Color color;
  final String title;
  final IconData iconData;
  const feature_button({super.key, required this.color, required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = 70;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 23, bottom: 23),
        child: Row(
          children: [
            Container(
              width: 24,
              child: Icon(
                iconData,
                size: 24,
                color: color,
              ),
            ),

            SizedBox(width: 15,),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 1, bottom: 1),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    title,
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 10,),

            Container(
              width: 24,
              child: Icon(
                Icons.chevron_right,
                size: 24,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
