import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/finaldata.dart';
import '../../../../../data/voucherData/UserUse.dart';
import '../../../../../data/voucherData/Voucher.dart';
import 'item_voucher_select.dart';

class general_select extends StatefulWidget {
  final Voucher voucher;
  final double cost;
  final VoidCallback ontap;
  const general_select({super.key, required this.voucher, required this.cost, required this.ontap});

  @override
  State<general_select> createState() => _general_selectState();
}

class _general_selectState extends State<general_select> {
  final List<Voucher> voucherList = [];
  int count = 0;

  void getVoucherData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Voucher").onValue.listen((event) {
      voucherList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        Voucher voucher = Voucher.fromJson(value);
        DateTime start = DateTime(voucher.startTime.year, voucher.startTime.month, voucher.startTime.day, voucher.startTime.hour, voucher.startTime.minute, voucher.startTime.second);
        DateTime end = DateTime(voucher.endTime.year, voucher.endTime.month, voucher.endTime.day, voucher.endTime.hour, voucher.endTime.minute, voucher.endTime.second);
        if (start.isBefore(DateTime.now()) && end.isAfter(DateTime.now())) {
          //check xem có còn đủ lượt dùng voucher không
          print('Xong bước 1');
          if (check_total_user_count(voucher)) {
            print('Xong bước 2');
            if (check_limit_per_custom(voucher)) {
              print('Xong bước 3');
              if (check_order_cost_with_voucher(voucher)) {
                print('Xong bước 4');
                voucherList.add(voucher);
              }
            }
          }
        }
      });
      setState(() {

      });
    });
  }


  //Lấy số lượt tài khoản này đã dùng voucher
  int getUseCount(Voucher voucher){
    for(UserUse useruse in voucher.CustomList) {
      if (useruse.id == finaldata.account.id) {
        return useruse.count;
      }
    }
    return 0;
  }

  //Kiểm tra xem người dùng này đã đủ giới hạn 1 người chưa
  bool check_limit_per_custom(Voucher voucher) {
    if (getUseCount(voucher) < voucher.perCustom) {
      return true;
    }
    return false;
  }

  //Kiểm tra xem voucher đã đủ giới hạn chưa
  bool check_total_user_count(Voucher voucher) {
    int count = 0;
    for (UserUse userUse in voucher.CustomList) {
      count = count + userUse.count;
    }
    if (count < voucher.maxCount) {
      return true;
    }
    return false;
  }

  //Kiểm tra xem đơn hàng này có đủ tiêu chuẩn để nhập voucher không
  bool check_order_cost_with_voucher(Voucher voucher) {
    if (widget.cost >= voucher.mincost) {
      if (voucher.type == 1) {
        if (widget.cost >= voucher.Money) {
          return true;
        } else {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVoucherData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Container(
              height: height/2-40,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: voucherList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: item_voucher_select(voucher: voucherList[index], event: () {
                      widget.voucher.Setdata(voucherList[index]);
                      widget.ontap();
                      Navigator.of(context).pop();
                    },
                    ),
                  );
                },
              )
          ),
        ),
      ),
    );
  }
}
