import 'package:flutter/material.dart';
import 'package:buysmartm/data/product/Product.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/item_product/add_to_cart_dialog.dart';
import 'package:buysmartm/screen/utils/utils.dart';

import '../../../../product_view_screen/product_view_controller/product_view_controller.dart';

class add_to_cart_button extends StatefulWidget {
  final Product product;
  const add_to_cart_button({super.key, required this.product});

  @override
  State<add_to_cart_button> createState() => _add_to_cart_buttonState();
}

class _add_to_cart_buttonState extends State<add_to_cart_button> {
  int numberProduct = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return GestureDetector(
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Color.fromARGB(255, 22, 143, 136),
        ),
        child: Center(
          child: Icon(
            Icons.add_shopping_cart_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return add_to_cart_dialog(product: widget.product);
          },
        );
      },
    );
  }
}
