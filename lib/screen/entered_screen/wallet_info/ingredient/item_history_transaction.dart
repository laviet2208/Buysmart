import 'package:flutter/material.dart';
import '../../../../data/historyData/Transaction.dart';
import '../../../../data/otherdata/Tool.dart';

class item_history_transaction extends StatefulWidget {
  final TransactionHis his;
  const item_history_transaction({super.key, required this.his});

  @override
  State<item_history_transaction> createState() => _item_history_transactionState();
}

class _item_history_transactionState extends State<item_history_transaction> {

  String convertCode(String code) {
    // Lấy các phần từ chuỗi mã
    String time = code.substring(5, 11);
    String date = code.substring(11, 19);

    // Định dạng thời gian
    String formattedTime = "${time.substring(0, 2)}:${time.substring(2, 4)}:${time.substring(4, 6)}";

    // Định dạng ngày tháng
    String formattedDate = "${date.substring(0, 2)}/${date.substring(2, 4)}/${date.substring(4, 8)}";

    // Kết hợp thời gian và ngày tháng
    return "$formattedTime $formattedDate";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                convertCode(widget.his.id),
                style: TextStyle(
                  fontFamily: 'sf',
                  fontSize: width/30,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.his.type == 1 ? ('+ ' + getStringNumber(widget.his.money) + ' .USDT') : ('- ' + getStringNumber(widget.his.money) + ' .USDT'),
                style: TextStyle(
                  fontFamily: 'sf',
                  fontSize: width/30,
                  color: widget.his.type == 1 ? Colors.blue : Colors.red,
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.his.content,
                style: TextStyle(
                  fontFamily: 'sf',
                  fontSize: width/30,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
