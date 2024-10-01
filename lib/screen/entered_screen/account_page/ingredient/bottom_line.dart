import 'package:flutter/material.dart';

class bottom_line extends StatelessWidget {
  const bottom_line({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: Container(
        height: 0.5,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }
}
