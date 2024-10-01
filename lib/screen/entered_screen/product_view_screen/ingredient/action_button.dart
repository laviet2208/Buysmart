import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';
import '../../../../data/product/Product.dart';
import '../product_view_controller/product_view_controller.dart';

class action_button extends StatelessWidget {
  final Product product;
  final int number;
  const action_button({super.key, required this.product, required this.number});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 243, 175, 74)),
                  ),
                  onPressed: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      finaldata.mainLang.buyitnow,
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.white,
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(const BorderSide(color: Color.fromARGB(255, 243, 175, 74), width: 1)),
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  ),
                  onPressed: () {
                    product_view_controller.add_to_cart_handle(product, number);
                    print('number:: ' + (finaldata.cartList.map((e) => e.number.toString()).toString()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      finaldata.mainLang.addtocart,
                      style: TextStyle(
                        fontFamily: 'muli',
                        color: Color.fromARGB(255, 243, 175, 74),
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
