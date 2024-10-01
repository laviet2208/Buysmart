import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/cartData/CartData.dart';
import '../../../../../../data/otherdata/Tool.dart';

class item_product_in_his extends StatefulWidget {
  final Cartdata cartdata;
  const item_product_in_his({super.key, required this.cartdata});

  @override
  State<item_product_in_his> createState() => _item_product_in_hisState();
}

class _item_product_in_hisState extends State<item_product_in_his> {
  String url = '';
  void _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('product').child(widget.cartdata.product.id).child(widget.cartdata.product.id + '_0.png');
    url = await ref.getDownloadURL();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getImageURL();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(width: 10,),

                Container(
                  width: (width - 30)/3,
                  height: (width - 30)/3,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: url != '' ?  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url, fit: BoxFit.fitHeight,),
                    ) : null,
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.cartdata.product.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/25,
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          height: 30,
                          child: Row(
                            children: [
                              Text(
                                'Number',
                                style: TextStyle(
                                  fontFamily: 'muli',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),

                              SizedBox(width: 10,),

                              Container(
                                width: width/6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.cartdata.number.toString(),
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getStringNumber(widget.cartdata.product.cost) + ' .usd',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
