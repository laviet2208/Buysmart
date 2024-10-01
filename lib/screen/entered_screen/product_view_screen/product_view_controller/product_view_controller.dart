import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../data/cartData/CartData.dart';
import '../../../../data/finaldata.dart';
import '../../../../data/product/Product.dart';
import '../../../utils/utils.dart';

class product_view_controller {
  static Future<Product> get_product(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").child(id).once();
    final dynamic data = snapshot.snapshot.value;
    return Product.fromJson(data);
  }

  static Future<List<String>> get_all_image(String id) async {
    final ListResult result = await FirebaseStorage.instance.ref().child('product').child(id).listAll();
    final List<Reference> allFiles = result.items;
    List<String> urls = [];
    for (Reference file in allFiles) {
      final String downloadUrl = await file.getDownloadURL();
      urls.add(downloadUrl);
    }
    return urls;
  }

  static void add_to_cart_handle(Product product, int number) {
    if (number > 0) {
      if (product.id != '') {
        bool check = true;
        for (Cartdata cartdata in finaldata.cartList) {
          if (cartdata.product.id == product.id) {
            cartdata.number = cartdata.number + number;
            check = false;
            break;
          }
        }
        if (check) {
          finaldata.cartList.add(Cartdata(product: product, number: number));
        }
        toastMessage('Add success');
      } else {
        toastMessage('Product error');
      }
    } else {
      toastMessage('Number must bigger than 0');
    }
  }
}