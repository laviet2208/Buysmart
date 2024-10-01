import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../../data/cartData/CartData.dart';
import '../../../../../data/otherdata/Tool.dart';

class item_product_in_checkout extends StatefulWidget {
  final Cartdata cartdata;
  const item_product_in_checkout({super.key, required this.cartdata});

  @override
  State<item_product_in_checkout> createState() => _item_product_in_checkoutState();
}

class _item_product_in_checkoutState extends State<item_product_in_checkout> {
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
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: width/4.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: Center(
                              child: Text(
                                widget.cartdata.product.costBeforeSale != 0 ? ('Save ' + calculateDiscountPercentage(widget.cartdata.product.costBeforeSale, widget.cartdata.product.cost).toString() + '%') : 'Last one',
                                style: TextStyle(
                                  fontFamily: 'sf',
                                  color: Colors.red,
                                  fontSize: width/30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.cartdata.product.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'sf',
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
                                  fontFamily: 'sf',
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
                                      fontFamily: 'sf',
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
                            getStringNumber(widget.cartdata.product.cost) + ' .USDT',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'sf',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/20,
                            ),
                          ),
                        ),

                        SizedBox(height: 4,),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getStringNumber(widget.cartdata.product.costBeforeSale) + ' .USDT',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'sf',
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.normal,
                              fontSize: width/25,
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
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
