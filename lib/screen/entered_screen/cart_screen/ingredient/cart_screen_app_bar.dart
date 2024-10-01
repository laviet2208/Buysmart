import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class cart_screen_app_bar extends StatelessWidget {
  final Widget beforeWidget;
  const cart_screen_app_bar({super.key, required this.beforeWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            width: 40,
            height: 40,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => beforeWidget),
            );
          },
        ),

        SizedBox(width: 30,),

        Expanded(
          child: Container(
            height: 24,
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'Buy smart cart',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'muli',
                color: Colors.black,
                fontSize: 100,
              ),
            ),
          ),
        ),

        SizedBox(width: 20,),
      ],
    );
  }
}
