import 'package:buysmartm/screen/before_screen/preview_screen/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buysmartm/data/product/ProductDirectory.dart';

import '../../../data/finaldata.dart';
import '../main_page/ingredient/directory_area/item_product/item_product.dart';
import '../product_view_screen/product_view_screen.dart';
import 'ingredient/product_type_viewall_appbar.dart';

class product_directory_viewall extends StatefulWidget {
  final ProductDirectory productDirectory;
  final Widget beforeWidget;
  final List<String> productShow;
  const product_directory_viewall({super.key, required this.productDirectory, required this.beforeWidget, required this.productShow});

  @override
  State<product_directory_viewall> createState() => _product_directory_viewallState();
}

class _product_directory_viewallState extends State<product_directory_viewall> {
  ScrollController _scrollController = ScrollController();
  List<int> _items = List.generate(10, (index) => index); // Khởi tạo với 10 phần tử đầu tiên
  bool _isLoading = false;

  Future<void> _refresh() async {

  }

  Future<void> _loadMoreItems() async {
    if (_items.length >= widget.productShow.length) {
      return; // Đã tải hết các phần tử
    }

    setState(() {
      _isLoading = true;
    });

    // Giả lập thời gian tải dữ liệu
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      int nextIndex = _items.length;
      int loadCount = (widget.productShow.length - nextIndex) < 10 ? (widget.productShow.length - nextIndex) : 10;
      _items.addAll(List.generate(loadCount, (index) => nextIndex + index));
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadMoreItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 241, 242),
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
                child: Scaffold(
                  appBar: AppBar(
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    title: product_type_viewall_appbar(title: widget.productDirectory.name, beforeWidget: widget.beforeWidget, currentWidget: widget,),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Container(
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: Container(
                        child: widget.productShow.length != 0 ? ListView(
                          controller: _scrollController,
                          children: [
                            SizedBox(height: 10,),

                            widget.productShow.length != 0 ? Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // số phần tử trên mỗi hàng
                                    mainAxisSpacing: 20, // khoảng cách giữa các hàng
                                    crossAxisSpacing: 15, // khoảng cách giữa các cột
                                    childAspectRatio: 2/3,
                                  ),
                                  itemCount: _items.length + (_isLoading && _items.length < widget.productShow.length ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == _items.length) {
                                      return Container(alignment: Alignment.center ,child: SpinKitFoldingCube(color: Color.fromARGB(255, 255, 190, 93), size: 30,),);
                                    }
                                    return GestureDetector(
                                      child: item_product(id: widget.productShow[index], productList: widget.productShow, event: () {setState(() {});}, beforeWidget: widget,),
                                      onTap: () {
                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => product_view_screen(id: widget.productDirectory.productList[index], beforeWidget: widget)));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ) : Container(height: height - 10, alignment: Alignment.center, child: Text('There is not any products in here!', style: TextStyle(fontSize: 12, color: Colors.black),),),

                            SizedBox(height: 30,),
                          ],
                        ) : Text('There is not any products in here!', style: TextStyle(fontSize: 12, color: Colors.black),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (finaldata.account.id != '') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => widget.beforeWidget));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => preview_screen()));
        }
        return true;
      },
    );
  }
}
