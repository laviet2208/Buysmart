import 'package:buysmartm/data/finaldata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buysmartm/data/product/ProductDirectory.dart';
import 'package:buysmartm/screen/before_screen/signin_screen/signin_screen.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/directory_area/directory_area.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/search_box.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/slogan_and_cart.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/ads_area/ads_area.dart';
import 'package:buysmartm/screen/entered_screen/main_page/ingredient/product_type_area/product_type_area.dart';
import 'package:buysmartm/screen/entered_screen/main_page/main_page_controller.dart';
import '../../../data/final_mainpage_data/final_mainpage_data.dart';
import '../../utils/utils.dart';

class preview_screen extends StatefulWidget {
  const preview_screen({super.key});

  @override
  State<preview_screen> createState() => _preview_screenState();
}

class _preview_screenState extends State<preview_screen> {
  bool loading = false;

  Future<void> _refresh() async {
    loading = true;
    setState(() {});
    final_mainpage_data.adsList = await main_page_controller.get_ads_list();
    final_mainpage_data.adsUrl.clear();
    for (int i = 0; i < final_mainpage_data.adsList.length; i++) {
      String url = await main_page_controller.getImageURL('Ads/' + final_mainpage_data.adsList[i].id + '.png');
      final_mainpage_data.adsUrl.add(url);
      setState(() {});
    }
    final_mainpage_data.typeList = await main_page_controller.get_type_list();
    setState(() {});
    final_mainpage_data.directory_id_list = await main_page_controller.get_directory_ui();
    final_mainpage_data.directory_list.clear();
    for (int i = 0; i < final_mainpage_data.directory_id_list.length; i++) {
      ProductDirectory save = await main_page_controller.get_directory(final_mainpage_data.directory_id_list[i]);
      final_mainpage_data.directory_list.add(save);
      setState(() {});
    }
    loading = false;
    setState(() {});
    final_mainpage_data.number_open = -1;
    final_mainpage_data.number_open = final_mainpage_data.number_open + 1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('id: ' + finaldata.account.id);
    if (final_mainpage_data.number_open > 3 || final_mainpage_data.number_open == -1) {
      _refresh();
    } else {
      final_mainpage_data.number_open = final_mainpage_data.number_open + 1;
    }

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 241, 242),
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
                bottom: 0,
                left: 0,
                right: 0,
                child: RefreshIndicator(
                  child: Container(
                    alignment: Alignment.center,
                    child: !loading ? ListView(
                      children: [
                        SizedBox(height: 5,),

                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: slogan_and_cart(),
                        ),

                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            child: search_box(),
                            onTap: () {
                              toastMessage('Please use your account to continue');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => signin_screen()));
                            },
                          ),
                        ),

                        SizedBox(height: 20,),

                        ads_area(adsList: final_mainpage_data.adsList, imgList: final_mainpage_data.adsUrl,),

                        SizedBox(height: 10,),

                        product_type_area(typeList: final_mainpage_data.typeList),

                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            child: ListView.builder(
                              itemCount: final_mainpage_data.directory_list.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: directory_area(productDirectory: final_mainpage_data.directory_list[index]),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ) : Container(child: SpinKitFoldingCube(color: Color.fromARGB(255, 255, 190, 93), size: 30,),),),
                  onRefresh: _refresh,
                ),
              ),

              // Positioned(
              //   top: 0,
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: GestureDetector(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.transparent,
              //       ),
              //     ),
              //     onTap: () {
              //       toastMessage('Please use your account to continue');
              //       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => signin_screen()));
              //     },
              //   ),
              // ),

              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: GestureDetector(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 243, 175, 74)),
                      ),
                      onPressed: () async {
                        toastMessage('Please use your account to continue');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => signin_screen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7, bottom: 7),
                        child: !loading ? Text(
                          'Login to continue',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                            fontSize: width/25,
                            fontWeight: FontWeight.normal,
                          ),
                        ) : CircularProgressIndicator(color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
