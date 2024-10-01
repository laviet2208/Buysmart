import 'package:firebase_database/firebase_database.dart';
import '../../../../data/noticeData/noticeData.dart';

class notice_page_controller {
  static Future<List<noticeData>> get_notice_list() async {
    List<noticeData> list = [];
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Notification").orderByChild('status').equalTo(0).once();
    final dynamic data = snapshot.snapshot.value;
    data.forEach((key, value) {
      noticeData data = noticeData.fromJson(value);
      list.add(data);
    });
    return list;
  }
}