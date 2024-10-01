import 'package:flutter/material.dart';

import '../../../../../../data/product/Product.dart';
import '../../../../../utils/utils.dart';
import '../../../../product_view_screen/product_view_controller/product_view_controller.dart';

class add_to_cart_dialog extends StatefulWidget {
  final Product product;
  const add_to_cart_dialog({super.key, required this.product});

  @override
  State<add_to_cart_dialog> createState() => _add_to_cart_dialogState();
}

class _add_to_cart_dialogState extends State<add_to_cart_dialog> {
  int numberProduct = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Enter quantity', style: TextStyle(fontFamily: 'sf', fontSize: 14, fontWeight: FontWeight.bold,),),
      content: Container(
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
                    int newValue = numberProduct - 1;
                    numberProduct = newValue.clamp(1, 100);
                  }),
                ),

                Text(numberProduct.toString()),

                IconButton(
                  icon: Icon(Icons.add, size: 14,),
                  onPressed: () => setState(() {
                    int newValue = numberProduct + 1;
                    numberProduct = newValue.clamp(1, 100);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            product_view_controller.add_to_cart_handle(widget.product, numberProduct);
            toastMessage('Add success');
            Navigator.of(context).pop();
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
