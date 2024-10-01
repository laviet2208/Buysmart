import 'package:flutter/material.dart';
import 'package:buysmartm/data/cartData/CartData.dart';

class change_cart_number extends StatefulWidget {
  final Cartdata cartdata;
  final VoidCallback event;
  const change_cart_number({super.key, required this.cartdata, required this.event});

  @override
  State<change_cart_number> createState() => _change_cart_numberState();
}

class _change_cart_numberState extends State<change_cart_number> {
  int numberProduct = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberProduct = widget.cartdata.number;
  }

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
            widget.cartdata.number = numberProduct;
            widget.event();
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
