import 'package:firebase_database/firebase_database.dart';
import '../../../../../../data/finaldata.dart';
import '../../../../data/orderData/Order.dart';

class history_order_controller {
  static Future<List<Order>> get_order_list() async {
    List<Order> list = [];
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Order").orderByChild('owner').equalTo(finaldata.account.id).once();
    final dynamic data = snapshot.snapshot.value;
    data.forEach((key, value) {
      Order data = Order.fromJson(value);
      list.add(data);
    });
    return list;
  }
}