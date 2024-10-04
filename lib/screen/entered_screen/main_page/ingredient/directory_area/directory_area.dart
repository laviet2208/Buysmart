import 'package:auto_size_text/auto_size_text.dart';
import 'package:buysmartm/screen/entered_screen/main_page/main_page_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/product/ProductDirectory.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/item_product/item_product.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/item_product/item_product_type_2.dart';
import 'package:buysmartm/screen/entered_screen/main_screen/main_screen.dart';
import 'package:buysmartm/screen/entered_screen/product_view_screen/product_view_screen.dart';
import 'package:buysmartm/screen/entered_screen/product_viewall/product_directory_viewall.dart';

import '../../../../../data/final_mainpage_data/final_mainpage_data.dart';
import '../../../../../data/finaldata.dart';
import '../../../../utils/utils.dart';

class directory_area extends StatefulWidget {
  final ProductDirectory productDirectory;
  const directory_area({super.key, required this.productDirectory});

  @override
  State<directory_area> createState() => _directory_areaState();
}

class _directory_areaState extends State<directory_area> {
  List<String> productShow = [];

  // Future<int> get_product_status(String id) async {
  //   final reference = FirebaseDatabase.instance.ref();
  //   DatabaseEvent snapshot = await reference.child('productList').child(id).child('showStatus').once();
  //   final dynamic data = snapshot.snapshot.value;
  //   return int.parse(data.toString());
  // }

  Future<void> getProductList() async {
    for (int i = 0; i < widget.productDirectory.productList.length; i++) {
      int showStatus = await main_page_controller.get_product_status(widget.productDirectory.productList[i]);
      if (showStatus == 1) {
        productShow.add(widget.productDirectory.productList[i]);
      }
      setState(() {

      });
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (final_mainpage_data.number_open > 3 || final_mainpage_data.number_open == -1) {
    //   getProductList();
    // }
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15,),

            Container(
              child: Row(
                children: [
                  SizedBox(width: 15,),

                  Expanded(
                    child: Container(
                      child: Text(
                        widget.productDirectory.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: width/22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 15,),

                  GestureDetector(
                    child: Container(
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: width/30,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_directory_viewall(productDirectory: widget.productDirectory, beforeWidget: main_screen(), productShow: productShow,)));
                    },
                  ),

                  SizedBox(width: 10,),
                ],
              ),
            ),

            SizedBox(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 15),
              child: Container(
                height: ((MediaQuery.of(context).size.width - 60)/2) * 1.5 + 8,
                alignment: Alignment.center,
                child: productShow.length != 0 ? ListView.builder(
                  itemCount: productShow.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: item_product(id: productShow[index], productList: productShow, event: () {}, beforeWidget: main_screen(),),
                      ),
                      onTap: () {
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_view_screen(id: widget.productDirectory.productList[index], beforeWidget: main_screen())));
                      },
                    );
                  },
                ) : Text('There is not any products in here!', style: TextStyle(fontSize: 12, color: Colors.grey),),
              ),
            ),

            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
