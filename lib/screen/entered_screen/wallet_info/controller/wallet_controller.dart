import 'package:firebase_database/firebase_database.dart';

import '../../../../data/finaldata.dart';
import '../../../../data/historyData/Transaction.dart';

class wallet_controller {
  static Future<List<TransactionHis>> get_his_list() async {
    List<TransactionHis> list = [];
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Transaction").orderByChild('owner').equalTo(finaldata.account.id).once();
    final dynamic data = snapshot.snapshot.value;
    data.forEach((key, value) {
      TransactionHis data = TransactionHis.fromJson(value);
      list.add(data);
    });
    return list;
  }
}