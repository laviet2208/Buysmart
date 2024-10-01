import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../data/MoneyRequest/MoneyRequest.dart';
import '../../../../../data/finaldata.dart';
import '../../../../../data/otherdata/Tool.dart';
import '../../../../utils/utils.dart';

class Withdrawal_requirements_form extends StatefulWidget {
  const Withdrawal_requirements_form({super.key});

  @override
  State<Withdrawal_requirements_form> createState() => _Withdrawal_requirements_formState();
}

class _Withdrawal_requirements_formState extends State<Withdrawal_requirements_form> {
  bool loading = false;
  TextEditingController moneyController = TextEditingController();
  bool us10 = true;
  bool us20 = false;
  bool us50 = false;
  bool us100 = false;
  bool us200 = false;
  bool other = false;
  void _selectMoney() {

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text(
        'Complete the form to continue',
        maxLines: 1,
        style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'sf', fontWeight: FontWeight.bold,),
      ),
      content: Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Text('Deposit 10 USDT', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal,),),
              value: us10,
              onChanged: (bool? value) {
                setState(() {
                  us10 = value!;
                  us20 = false;
                  us50 = false;
                  us100 = false;
                  us200 = false;
                  other = false;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Deposit 20 USDT', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal,),),
              value: us20,
              onChanged: (bool? value) {
                setState(() {
                  us10 = false;
                  us20 = value!;
                  us50 = false;
                  us100 = false;
                  us200 = false;
                  other = false;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Deposit 50 USDT', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal,),),
              value: us50,
              onChanged: (bool? value) {
                setState(() {
                  us10 = false;
                  us20 = false;
                  us50 = value!;
                  us100 = false;
                  us200 = false;
                  other = false;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Deposit 100 USDT', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal,),),
              value: us100,
              onChanged: (bool? value) {
                setState(() {
                  us10 = false;
                  us20 = false;
                  us50 = false;
                  us100 = value!;
                  us200 = false;
                  other = false;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Deposit 200 USDT', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal,),),
              value: us200,
              onChanged: (bool? value) {
                setState(() {
                  us10 = false;
                  us20 = false;
                  us50 = false;
                  us100 = false;
                  us200 = value!;
                  other = false;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Deposit other money', textAlign: TextAlign.start,style: TextStyle(fontFamily: 'sf', fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold,),),
              value: other,
              onChanged: (bool? value) {
                setState(() {
                  us10 = false;
                  us20 = false;
                  us50 = false;
                  us100 = false;
                  us200 = false;
                  other = value!;
                });
              },
            ),

            other ? Container(
              width: width - 50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                        child: TextField(
                          controller: moneyController,
                          decoration: InputDecoration(
                            filled: true,
                            // border: InputBorder.none,
                            fillColor: Colors.transparent, // Background color when not focused
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'Enter amount(Only number)',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          cursorColor: Color.fromARGB(255, 23, 87, 83),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8,),
                ],
              ),
            ) : Container(),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
            onPressed: () async {
              if (us10 || us20 || us50 || us100 || us200 || other) {
                if (other) {
                  if (moneyController.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });
                    if (double.parse(moneyController.text.toString()) > 0) {
                      MoneyRequest monrequest = MoneyRequest(id: '', owner: finaldata.account, status: 'A', createTime: getCurrentTime(), money: double.parse(moneyController.text.toString()), type: 2);
                      String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                      monrequest.id = 'RQ' + id;
                      DatabaseReference database = FirebaseDatabase.instance.ref("MoneyRequest");
                      await database.child(monrequest.id).set(monrequest.toJson());
                      setState(() {
                        loading = false;
                      });
                      toastMessage('Submitted successfully, please wait for processing');
                      Navigator.of(context).pop();
                    } else {
                      toastMessage('Please enter amount');
                    }
                  }
                } else {
                  setState(() {
                    loading = true;
                  });
                  MoneyRequest monrequest = MoneyRequest(id: '', owner: finaldata.account, status: 'A', createTime: getCurrentTime(), money: 0, type: 2);
                  String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                  monrequest.id = 'RQ' + id;
                  if (us10) {
                    monrequest.money = 10;
                  }
                  if (us20) {
                    monrequest.money = 20;
                  }
                  if (us50) {
                    monrequest.money = 50;
                  }
                  if (us100) {
                    monrequest.money = 10;
                  }
                  if (us200) {
                    monrequest.money = 200;
                  }
                  DatabaseReference database = FirebaseDatabase.instance.ref("MoneyRequest");
                  await database.child(monrequest.id).set(monrequest.toJson());
                  setState(() {
                    loading = false;
                  });
                  toastMessage('Submitted successfully, please wait for processing');
                  Navigator.of(context).pop();
                }
              } else {
                toastMessage('Please enter amount');
              }
            },
            child: Text(
              'Send request',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            )
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel request',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            )
        ),
      ],
    );
  }
}
