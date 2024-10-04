import 'package:flutter/material.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/ads_area/item_ads.dart';
import 'package:buysmartm/screen/entered_screen/main_screen/main_screen.dart';
import 'package:buysmartm/screen/entered_screen/product_view_screen/product_view_screen.dart';
import '../../../../../data/AdsData/AdsData.dart';
import '../../../../../data/finaldata.dart';
import '../../../../before_screen/signin_screen/signin_screen.dart';
import '../../../../utils/utils.dart';

class ads_area extends StatelessWidget {
  final List<AdsData> adsList;
  final List<String> imgList;
  const ads_area({super.key, required this.adsList, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 0),
      child: Container(
        height: 170,
        child: ListView.builder(
          itemCount: adsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: item_ads(adsData: adsList[index], url: imgList[index],),
              ),
              onTap: () {
                if(finaldata.account.id != '') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => product_view_screen(id: adsList[index].productId, beforeWidget: main_screen())),);
                } else {
                  toastMessage('Please use your account to continue');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => signin_screen()));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
