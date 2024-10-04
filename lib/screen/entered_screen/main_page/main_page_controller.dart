import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:buysmartm/data/AdsData/AdsData.dart';
import 'package:buysmartm/data/product/ProductDirectory.dart';
import 'package:buysmartm/data/product/ProductType.dart';

class main_page_controller {
  static Future<List<AdsData>> get_ads_list() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("adsData").orderByChild('status').equalTo(1).once();
    final dynamic data = snapshot.snapshot.value;
    List<AdsData> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        dataList.add(AdsData.fromJson(value));
      });
    }
    return dataList;
  }

  static Future<List<ProductType>> get_type_list() async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("productType").once();
    final dynamic data = snapshot.snapshot.value;
    List<ProductType> dataList = [];
    if (data != null) {
      data.forEach((key, value) {
        dataList.add(ProductType.fromJson(value));
      });
    }
    return dataList;
  }

  static Future<List<String>> get_directory_ui() async {
    final reference = FirebaseDatabase.instance.ref();
    List<String> directoryList = [];
    DatabaseEvent snapshot = await reference.child('UI').child('productDirectory').once();
    final dynamic data = snapshot.snapshot.value;
    for (final result in data) {
      String id = result.toString();
      directoryList.add(id);
    }
    return directoryList;
  }

  static Future<ProductDirectory> get_directory(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child('productDirectory').child(id).once();
    final dynamic data = snapshot.snapshot.value;
    return ProductDirectory.fromJson(data);
  }

  static Future<int> get_product_status(String id) async {
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child('productList').child(id).child('showStatus').once();
    final dynamic data = snapshot.snapshot.value;
    return int.parse(data.toString());
  }

  static Future<String> getImageURL(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // Nếu có lỗi, chẳng hạn như path không tồn tại, trả về chuỗi rỗng
      return '';
    }
  }
}