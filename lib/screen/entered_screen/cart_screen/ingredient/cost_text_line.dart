import 'package:flutter/material.dart';

class cost_text_line extends StatelessWidget {
  final String title;
  final String content;
  final double size;
  final Color contentColor;
  final Color titleColor;
  const cost_text_line({super.key, required this.title, required this.content, required this.size, required this.contentColor, required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'muli',
              color: titleColor,
              fontSize: size,
            ),
          ),

          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'muli',
                color: contentColor,
                fontSize: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
