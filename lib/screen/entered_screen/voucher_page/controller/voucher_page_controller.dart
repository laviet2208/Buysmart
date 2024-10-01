import 'package:firebase_database/firebase_database.dart';

import '../../../../data/voucherData/Voucher.dart';

class voucher_page_controller {
  static Future<List<Voucher>> get_voucher_list() async {
    List<Voucher> list = [];
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Voucher").once();
    final dynamic data = snapshot.snapshot.value;
    data.forEach((key, value) {
      Voucher voucher = Voucher.fromJson(value);
      list.add(voucher);
    });
    return list;
  }
}