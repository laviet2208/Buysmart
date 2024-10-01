import 'package:firebase_database/firebase_database.dart';
import '../../../../data/product/Product.dart';

class search_page_controller {
  static Future<List<Product>> get_product_list() async {
    List<Product> list = [];
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").once();
    final dynamic data = snapshot.snapshot.value;
    data.forEach((key, value) {
      Product data = Product.fromJson(value);
      list.add(data);
    });
    return list;
  }
}