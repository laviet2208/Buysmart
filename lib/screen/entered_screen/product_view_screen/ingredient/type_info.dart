import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../data/product/ProductType.dart';

class type_info extends StatefulWidget {
  final String id;
  const type_info({super.key, required this.id});

  @override
  State<type_info> createState() => _type_infoState();
}

class _type_infoState extends State<type_info> {
  String url = '';
  ProductType type = ProductType(id: '', createTime: getCurrentTime(), name: '', productList: []);

  void _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('productType').child(widget.id + '.png');
    url = await ref.getDownloadURL();
    setState(() {

    });
  }

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productType").child(widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      type = ProductType.fromJson(orders);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _getImageURL();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 0, right: 0),
        child: Container(
          height: 60,
          child: Row(
            children: [
              Container(
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Color.fromARGB(255, 219, 219, 219).withOpacity(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      image: url != '' ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(url),
                      ) : null,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10,),

              Expanded(
                child: Container(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          type.name + ' (' + type.productList.length.toString() + ' products)',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontSize: width/30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),



                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          finaldata.mainLang.positive,
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontSize: width/30,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10,),

              Container(
                width: 40,
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.view_agenda_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  onTap: () {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
