import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:buysmartm/data/product/Product.dart';
import 'package:buysmartm/data/product/ProductType.dart';

class product_directory_viewall_controller {
  static Future<ProductType> get_product_type(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productType").child(id).once();
    print('Chạy hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    return ProductType.fromJson(data);
  }

  static Future<List<Product>> get_product_list_by_type_id(String id, VoidCallback event) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('productType').equalTo(id).once();
    print('Gọi hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          dataList.add(product);
          event();
        }
      });
    }
    return dataList;
  }

  static Future<List<Product>> get_product_list_by_direct_id(String id, VoidCallback event) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('directoryList/0').equalTo(id).once();
    print('Gọi hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          dataList.add(product);
          event();
        }
      });
    }
    return dataList;
  }

  static Future<List<Product>> get_product_list_by_direct_id1(String id, VoidCallback event) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productList").orderByChild('directoryList/0').equalTo(id).once();
    print('Gọi hàm lấy type thành công');
    final dynamic data = snapshot.snapshot.value;
    List<Product> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          dataList.add(product);
          event();
        }
      });
    }
    return dataList;
  }
}