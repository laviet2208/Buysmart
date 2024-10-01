import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/screen/entered_screen/main_screen/main_screen.dart';
import 'package:buysmartm/screen/entered_screen/product_viewall/product_type_viewall.dart';
import '../../../../../data/product/ProductType.dart';
import 'item_product_type.dart';

class product_type_area extends StatefulWidget {
  final List<ProductType> typeList;
  const product_type_area({super.key, required this.typeList,});

  @override
  State<product_type_area> createState() => _product_type_areaState();
}

class _product_type_areaState extends State<product_type_area> {
  bool isAll = false;
  String allText = 'View all types>>';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: !isAll ? 20 : (width - 270)/4, right: !isAll ? 0 : (width - 270)/4),
            child: Container(
              height: !isAll ? 130 : null,
              child: !isAll ? ListView.builder(
                itemCount: widget.typeList.length,
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 15,),
                    child: GestureDetector(
                      child: item_product_type(productType: widget.typeList[index]),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_type_viewall(productType: widget.typeList[index], beforeWidget: main_screen())));
                      },
                    ),
                  );
                },
              ) : GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // số phần tử trên mỗi hàng
                mainAxisSpacing: 10, // khoảng cách giữa các hàng
                crossAxisSpacing: (width - 270)/4 - 5, // khoảng cách giữa các cột
                childAspectRatio: 3/4,
              ),
              itemCount: widget.typeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: item_product_type(productType: widget.typeList[index]),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_type_viewall(productType: widget.typeList[index], beforeWidget: main_screen())));
                  },
                );
              },
            ),
            ),
          ),

          SizedBox(height: 5,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              child: Container(
                height: 15,
                alignment: Alignment.centerRight,
                child: AutoSizeText(
                  allText,
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 100,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              onTap: () {
                if (allText == 'View all types>>') {
                  setState(() {
                    isAll = true;
                    allText = 'Hide<<';
                  });
                } else {
                  setState(() {
                    isAll = false;
                    allText = 'View all types>>';
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
