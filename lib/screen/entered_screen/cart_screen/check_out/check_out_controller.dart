import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/finaldata.dart';
import '../../../../data/historyData/Transaction.dart';
import '../../../../data/orderData/Order.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../data/voucherData/UserUse.dart';
import '../../../../data/voucherData/Voucher.dart';
import '../../../utils/utils.dart';

class check_out_controller {
  static Future<void> push_new_order(Order order, VoidCallback successEvent, VoidCallback failEvent) async {
    DatabaseReference database = FirebaseDatabase.instance.ref("Order");
    await database.child(order.id).set(order.toJson()).then((value) async {
      if (check_voucher_exist(order.voucher)) {
        int index = get_voucher_index(order.voucher);
        finaldata.account.voucherList.removeAt(index);
        DatabaseReference database1 = FirebaseDatabase.instance.ref("Account");
        await database1.child(finaldata.account.id).set(finaldata.account.toJson());
      } else {
        await pushVoucher(order.voucher);
      }
      DatabaseReference database = FirebaseDatabase.instance.ref("Account");
      String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
      TransactionHis transactionHis = TransactionHis(id: 'TRANS' + id, content: order.id + ' order payment', money: (calculatetotalMoney() - getVoucherSale(order.voucher, calculatetotalMoney())), owner: finaldata.account.id, type: 0);
      finaldata.account.money = finaldata.account.money - (calculatetotalMoney() - getVoucherSale(order.voucher, calculatetotalMoney()));
      await database.child(finaldata.account.id).child('money').set(finaldata.account.money);
      database = FirebaseDatabase.instance.ref("Transaction");
      await database.child(transactionHis.id).set(transactionHis.toJson());
      toastMessage('Create order success');
      successEvent();
    }).onError((error, stackTrace) {
      failEvent();
      toastMessage(error.toString());
      print(error.toString());
    });
  }

  static bool check_voucher_exist(Voucher voucher) {
    for (int i = 0; i < finaldata.account.voucherList.length; i++) {
      if (finaldata.account.voucherList[i].id == voucher.id) {
        return true;
      }
    }
    return false;
  }

  static int get_voucher_index(Voucher voucher) {
    for (int i = 0; i < finaldata.account.voucherList.length; i++) {
      if (finaldata.account.voucherList[i].id == voucher.id) {
        return i;
      }
    }
    return -1;
  }

  static Future<void> pushVoucher(Voucher voucher) async {
    if (voucher.id != '') {
      voucher.useCount = voucher.useCount + 1;
      bool check = false;
      for (UserUse use in voucher.CustomList) {
        if (use.id == finaldata.account.id) {
          check = true;
          use.count = use.count + 1;
          break;
        }
      }
      if (!check) {
        voucher.CustomList.add(UserUse(id: finaldata.account.id, count: 1));
      }
      final reference = FirebaseDatabase.instance.ref();
      await reference.child('Voucher').child(voucher.id).set(voucher.toJson());
    }
  }
}
