import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buysmartm/screen/entered_screen/product_view_screen/ingredient/product_view_appbar.dart';

import '../../../data/otherdata/Tool.dart';
import '../../../data/product/Product.dart';
import 'ingredient/action_button.dart';
import 'ingredient/image_view.dart';
import 'ingredient/main_description.dart';
import 'ingredient/name_and_cost.dart';
import 'product_view_controller/product_view_controller.dart';

class product_view_screen extends StatefulWidget {
  final String id;
  final Widget beforeWidget;
  const product_view_screen({super.key, required this.id, required this.beforeWidget});

  @override
  State<product_view_screen> createState() => _product_view_screenState();
}

class _product_view_screenState extends State<product_view_screen> {
  bool loading = false;
  int numberProduct = 1;
  Product product = Product(id: '', name: '', productType: '', showStatus: 0, createTime: getCurrentTime(), description: '', directoryList: [], cost: 0, costBeforeSale: 0, inventory: 0, saleLimit: getCurrentTime(), subdescription: '', viName: '');
  List<String> imageUrls = [];

  Future<void> _Refresh() async {
    setState(() {
      loading = true;
    });
    product = await product_view_controller.get_product(widget.id);
    setState(() {
      loading = false;
    });
    imageUrls = await product_view_controller.get_all_image(widget.id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Refresh();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
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
                left: 0,
                bottom: 0,
                right: 0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: product_view_appbar(title: product.name == '' ? 'Loading...' : product.name, widget: widget.beforeWidget, currentWidget: widget,),
                  ),
                  body: Container(
                    child: RefreshIndicator(
                      child: ListView(
                        children: [
                          !loading ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10,),

                              image_view(imageUrls: imageUrls),

                              SizedBox(height: 10,),

                              name_and_cost(product: product),

                              Container(height: 10, decoration: BoxDecoration(color: Colors.white,),),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        IconButton(
                                          icon: Icon(Icons.remove, size: 14,),
                                          onPressed: () => setState(() {
                                            final newValue = numberProduct - 1;
                                            numberProduct = newValue.clamp(1, 100);
                                          }),
                                        ),

                                        Text(numberProduct.toString()),

                                        IconButton(
                                          icon: Icon(Icons.add, size: 14,),
                                          onPressed: () => setState(() {
                                            final newValue = numberProduct + 1;
                                            numberProduct = newValue.clamp(1, 100);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10, decoration: BoxDecoration(color: Colors.white,),),

                              action_button(product: product, number: numberProduct,),

                              Container(height: 10, decoration: BoxDecoration(color: Colors.white,),),

                              main_description(description: product.description),

                              SizedBox(height: 20,),
                            ],
                          ) : Container(height: height - 100, alignment: Alignment.center,  child: SpinKitFoldingCube(color: Color.fromARGB(255, 255, 190, 93), size: 30,),),
                        ],
                      ),
                      onRefresh: _Refresh,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
        return true;
      },
    );
  }
}
