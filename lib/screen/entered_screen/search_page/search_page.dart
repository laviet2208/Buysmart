import 'package:flutter/material.dart';
import '../../../data/finaldata.dart';
import '../../../data/product/Product.dart';
import '../main_screen/main_screen.dart';
import '../product_view_screen/product_view_screen.dart';
import 'ingredient/item_product_search.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  final searchController = TextEditingController();
  List<Product> filterList = [];

  void onSearchTextChanged(String value) {
    setState(() {
      filterList = finaldata.productList
          .where((product) =>
      product.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: width/(829/636),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/decor/decor1.png'),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40,),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10,),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),

                              SizedBox(width: 10,),

                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        hintText: 'Search product on Buy smart',
                                        hintStyle: TextStyle(color: Colors.grey[600]),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: onSearchTextChanged,
                                      cursorColor: Colors.blue, // Cursor color
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              Container(
                                width: 40,
                                child: Icon(
                                  Icons.mic_none,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.white,),
                        child: filterList.length != 0 ? ListView.builder(
                          itemCount: filterList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                child: item_product_search(product: filterList[index]),
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => product_view_screen(id: filterList[index].id, beforeWidget: main_screen())));
                                },
                              ),
                            );
                          },
                        ) : Text('There are no products here', style: TextStyle(fontSize: 14,color: Colors.black),),
                      ),
                    ),

                    SizedBox(height: 0,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
