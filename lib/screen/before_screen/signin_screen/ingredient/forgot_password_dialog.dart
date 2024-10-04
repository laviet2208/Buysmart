import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class forgot_password_dialog extends StatefulWidget {
  const forgot_password_dialog({super.key});

  @override
  State<forgot_password_dialog> createState() => _forgot_password_dialogState();
}

class _forgot_password_dialogState extends State<forgot_password_dialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Forgot password?', style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black,),),
      content: Text('We will transfer you to our customer service department!', style: TextStyle(fontFamily: 'sf', fontSize: 14, color: Colors.red,),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            launch("https://t.me/Buysmart_support");
          },
          child: Text(
            'Accept',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
