import 'package:auto_size_text/auto_size_text.dart';
import 'package:buysmartm/data/product/Product.dart';
import 'package:buysmartm/screen/before_screen/preview_screen/preview_screen.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/item_product/item_product_loading.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/item_product/item_product_type_1.dart';
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
import '../../../product_viewall/product_directory_viewall_controller.dart';

class directory_area extends StatefulWidget {
  final ProductDirectory productDirectory;
  const directory_area({super.key, required this.productDirectory});

  @override
  State<directory_area> createState() => _directory_areaState();
}

class _directory_areaState extends State<directory_area> {
  List<Product> productList = [];
  bool loading = false;
  Future<void> _refresh() async {
    setState(() {
      loading = true;
    });
    productList = await product_directory_viewall_controller.get_product_list_by_direct_id(widget.productDirectory.id, () {setState(() {loading = false;});});
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_directory_viewall(productDirectory: widget.productDirectory, beforeWidget: main_screen(),)));
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
                child: !loading ? (productList.length != 0 ? ListView.builder(
                  itemCount: productList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: item_product_type_1(product: productList[index],),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_view_screen(id: productList[index].id, beforeWidget: finaldata.account.id != '' ? main_screen() : preview_screen())));
                      },
                    );
                  },
                ) : Text('There is not any products in here!', style: TextStyle(fontSize: 12, color: Colors.grey),)) : ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: item_product_loading(),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
