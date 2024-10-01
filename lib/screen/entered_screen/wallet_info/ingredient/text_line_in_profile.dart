import 'package:flutter/material.dart';

import '../../../../../../data/finaldata.dart';

class text_line_in_profile extends StatelessWidget {
  final String title;
  final String content;
  const text_line_in_profile({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: width / 24,
                  fontFamily: 'sf',
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: content,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: width / 24,
                  fontFamily: 'sf',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
        ),
      ),
    );
  }
}
