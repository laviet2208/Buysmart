import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/product/Product.dart';

import '../../../../../../data/otherdata/Tool.dart';
import 'add_to_cart_button.dart';

class item_product_type_1 extends StatefulWidget {
  final Product product;
  const item_product_type_1({super.key, required this.product});

  @override
  State<item_product_type_1> createState() => _item_product_type_1State();
}

class _item_product_type_1State extends State<item_product_type_1> {
  String url = '';

  void _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('product').child(widget.product.id).child(widget.product.id + '_0.png');
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
    double width = (MediaQuery.of(context).size.width - 60)/2;
    double height = width * 1.5;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Container(
              width: width - 10,
              height: width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: url == '' ? Image.asset('assets/image/logo/mainlogo.png', fit: BoxFit.cover,) : Image.network(url, fit: BoxFit.fitWidth,),
              ),
            ),
          ),

          // Positioned(
          //   top: 10,
          //   left: 10,
          //   child: Container(
          //     width: 35,
          //     height: 35,
          //     decoration: BoxDecoration(
          //       color: Colors.grey.withOpacity(0.6),
          //       borderRadius: BorderRadius.circular(1000),
          //     ),
          //     child: Center(
          //       child: Icon(
          //         Icons.favorite_border,
          //         color: Colors.black,
          //         size: 20,
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
              top: 8 + width - 10,
              left: 5,
              right: 5,
              bottom: 0,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    width: width - 10,
                    child: Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width/12,
                        fontFamily: 'sf',
                        color: Color.fromARGB(255, 106, 106, 106),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 3,),

                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 50),
                    child: Text(
                      getStringNumber(widget.product.cost) + '.USDT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width/12,
                        fontFamily: 'sf',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 3,),

                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 50),
                    child: RichText(
                      text: widget.product.costBeforeSale > widget.product.cost ? TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: getStringNumber(widget.product.costBeforeSale) + '. USDT',
                            style: TextStyle(
                              fontSize: width / 16,
                              fontFamily: 'muli',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough, // Thêm gạch chéo
                              decorationColor: Colors.grey, // Màu gạch chéo
                              decorationThickness: 2,
                            ),
                          ),

                          TextSpan(
                            text: ' . ' + calculateDiscountPercentage(widget.product.costBeforeSale, widget.product.cost).toString() + '% off',
                            style: TextStyle(
                              fontSize: width/16,
                              fontFamily: 'muli',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ) : TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Maximum savings',
                            style: TextStyle(
                              fontSize: width/16,
                              fontFamily: 'muli',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: add_to_cart_button(product: widget.product,),
          ),
        ],
      ),
    );
  }
}
