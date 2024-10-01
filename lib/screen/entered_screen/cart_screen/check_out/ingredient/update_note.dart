import 'package:flutter/material.dart';
import '../../../../../data/finaldata.dart';
import '../../../../../data/orderData/Order.dart';
import '../../../../before_screen/signup_screen/edit_text_in_signup_step_1.dart';
import '../../../../utils/utils.dart';

class update_note extends StatefulWidget {
  final Order order;
  final VoidCallback event;
  const update_note({super.key, required this.order, required this.event});

  @override
  State<update_note> createState() => _update_noteState();
}

class _update_noteState extends State<update_note> {
  final noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteController.text = widget.order.note;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text('Add note', style: TextStyle(fontFamily: 'muli', fontSize: width/25, fontWeight: FontWeight.bold),),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      content: Container(
        width: width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            SizedBox(
              height: 50,
              child: edit_text_in_signup_step_1(controller: noteController, hint: 'Enter note', event: () {setState(() {});  },),
            ),

            SizedBox(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (noteController.text.isNotEmpty) {
              widget.order.note = noteController.text.toString();
              widget.event();
              Navigator.of(context).pop();
            } else {
              toastMessage('Please fill note');
            }
          },
          child: Text(
            finaldata.mainLang.saveinfomation,
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close form',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
