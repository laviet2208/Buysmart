import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/AdsData/AdsData.dart';

import '../../../main_screen/main_screen.dart';
import '../../../product_view_screen/product_view_screen.dart';

class item_ads extends StatefulWidget {
  final AdsData adsData;
  final String url;
  const item_ads({super.key, required this.adsData, required this.url});

  @override
  State<item_ads> createState() => _item_adsState();
}

class _item_adsState extends State<item_ads> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 170,
        width: 170 * (5184/2592),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(widget.url, fit: BoxFit.fitWidth,),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => product_view_screen(id: widget.adsData.productId, beforeWidget: main_screen())),);
      },
    );
  }
}
