import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/product/ProductType.dart';

import '../../../../../data/finaldata.dart';
import '../../../../utils/utils.dart';
import '../../../main_screen/main_screen.dart';
import '../../../product_viewall/product_type_viewall.dart';

class item_product_type extends StatefulWidget {
  final ProductType productType;
  const item_product_type({super.key, required this.productType});

  @override
  State<item_product_type> createState() => _item_product_typeState();
}

class _item_product_typeState extends State<item_product_type> {
  String url = '';
  void _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('productType').child(widget.productType.id + '.png');
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
    return GestureDetector(
      child: Container(
        height: 120,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
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
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(url),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Text(
                          widget.productType.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'sf',
                            color: Colors.black,
                            fontSize: width/33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent,),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (finaldata.account.id != '') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_type_viewall(productType: widget.productType, beforeWidget: main_screen())));
        } else {
          toastMessage('You must login for use this feature');
        }
      },
    );
  }
}

