import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class edit_text_in_account extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback event;
  final String title;
  final String hint;
  const edit_text_in_account({super.key, required this.textEditingController, required this.event, required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 22,
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              title,
              style: TextStyle(
                fontFamily: 'sf',
                fontSize: 100,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 8,),

          Container(
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
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent, // Background color when not focused
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[600]), // Hint text color
                ),
                onChanged: (value) {
                  event();
                },
                cursorColor: Color.fromARGB(255, 23, 87, 83),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
