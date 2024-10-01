import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../data/chatData/chatRoom.dart';
import '../../../../../data/chatData/messenger.dart';
import '../../../data/finaldata.dart';
import '../main_screen/main_screen.dart';
import 'ingredient/Item_messenger.dart';

class chatRoomScreen extends StatefulWidget {
  const chatRoomScreen({Key? key}) : super(key: key);

  @override
  State<chatRoomScreen> createState() => _chatRoomScreenState();
}

class _chatRoomScreenState extends State<chatRoomScreen> {
  chatRoom room = chatRoom(account: finaldata.account, messengerList: []);
  bool Loading = false;
  void getChatRoom() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Chatrooms").child(finaldata.account.id).onValue.listen((event) async {
      final dynamic Chatrooms = event.snapshot.value;
      if(Chatrooms != null) {
        room = chatRoom.fromJson(Chatrooms);
        setState(() {

        });
      } else {
        room = chatRoom(account: finaldata.account, messengerList: []);
        room.messengerList.add(messenger(type: 2, content: "Hello, this is Buy Smart's customer service department, how can we help you?"));
        pushChatRooms(room);
        setState(() {

        });
      }
    });
  }

  Future<void> pushChatRooms(chatRoom room) async {
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("Chatrooms").child(finaldata.account.id).set(room.toJson());
  }

  final messengerText = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blueGrey,),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => main_screen(),),);
            },
          ),
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Buy Smart Support',
                        style: TextStyle(
                          fontFamily: 'muli',
                          fontSize: 100,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5)
                          )
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 20,
                          bottom: 20,
                          right: 5,
                          child: GestureDetector(
                            child: Container(
                              width: 40,
                              child:!Loading ? Icon(
                                Icons.send,
                                color: messengerText.text.isNotEmpty ? Colors.blue : Colors.grey,
                              ) : CircularProgressIndicator(color: Colors.blue,),
                            ),
                            onTap: () async {
                              if (messengerText.text.isNotEmpty) {
                                messenger mes = messenger(type: 1, content: messengerText.text.toString());
                                room.messengerList.add(mes);
                                setState(() {
                                  Loading = true;
                                });
                                await pushChatRooms(room);

                                setState(() {
                                  Loading = false;
                                  messengerText.clear();
                                });
                              }
                            },
                          )
                      ),

                      Positioned(
                        top: 20,
                        bottom: 20,
                        left: 10,
                        right: 70,
                        child: Container(
                          child: TextFormField(
                            controller: messengerText,
                            onChanged: (newValue) {
                              setState(() {

                              });
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'roboto',
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.message_outlined),
                              hintText: finaldata.mainLang.support2,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'roboto',
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              //Xóa contentVerticalAlignment trong InputDecoration
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                bottom: 85,
                left: 10,
                right: 10,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: room.messengerList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Item_messenger(mes: room.messengerList[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => main_screen()));
        return true;
      },
    );
  }
}