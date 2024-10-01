import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:buysmartm/screen/before_screen/signin_screen/signin_screen.dart';

import 'controller/loading_controller.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({super.key});

  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Loading_Controller.isLogin(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 49, 127, 123),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                width: width/3 * 2,
                height: width/3 * 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/logo/yellowwhite.png'),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            SpinKitFoldingCube(
              color: Color.fromARGB(255, 255, 190, 93),
            ),
          ],
        ),
      ),
    );
  }
}