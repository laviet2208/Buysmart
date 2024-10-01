import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../data/otherdata/Tool.dart';
import '../../../../data/product/Product.dart';

class item_product_search extends StatefulWidget {
  final Product product;
  const item_product_search({super.key, required this.product});

  @override
  State<item_product_search> createState() => _item_product_searchState();
}

class _item_product_searchState extends State<item_product_search> {
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(width: 10,),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10), // Đặt bán kính bo tròn
                //   child: Container(
                //     width: (width - 40)/3,
                //     height: (width - 40)/3,
                //     decoration: url != '' ? BoxDecoration(
                //       color: Colors.blueGrey.withOpacity(0.2),
                //       image: DecorationImage(
                //         fit: BoxFit.fitWidth,
                //         image: NetworkImage(url),
                //       ),
                //     ) : null,
                //   ),
                // ),
                //
                // SizedBox(width: 20,),

                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.product.name,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width/30,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getStringNumber(widget.product.cost) + ' .usd',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: width/25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        widget.product.costBeforeSale != 0 ? Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: getStringNumber(widget.product.costBeforeSale) + ' USD',
                                  style: TextStyle(
                                    fontSize: width / 30,
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
                                    fontSize: width/30,
                                    fontFamily: 'muli',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SizedBox(height: 10,),
        ],
      ),
    );
  }
}
