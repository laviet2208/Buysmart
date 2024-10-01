import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/screen/entered_screen/notice_page/ingredient/notice_page_appbar.dart';

import '../../../data/noticeData/noticeData.dart';
import '../account_page/ingredient/account_page_app_bar.dart';
import 'controller/notice_page_controller.dart';
import 'ingredient/item_notice.dart';

class notice_page extends StatefulWidget {
  const notice_page({super.key});

  @override
  State<notice_page> createState() => _notice_pageState();
}

class _notice_pageState extends State<notice_page> {

  List<noticeData> dataList = [];

  Future<void> _refresh() async {
    dataList = await notice_page_controller.get_notice_list();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: width/(829/636),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/decor/decor1.png'),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: notice_page_appbar(),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: dataList.length != 0 ? Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: item_notice(data: dataList[index]),
                              );
                            },
                          ),
                        ) : Container(
                          height: height - 110,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "You don't have any notifications yet"
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
