import 'package:auto_size_text/auto_size_text.dart';
import 'package:buysmartm/screen/before_screen/signin_screen/ingredient/forgot_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/screen/before_screen/preview_screen/preview_screen.dart';
import 'package:buysmartm/screen/before_screen/signin_screen/ingredient/text_field_login.dart';
import 'package:buysmartm/screen/before_screen/signup_screen/signup_screen.dart';
import 'package:buysmartm/screen/entered_screen/main_screen/main_screen.dart';
import 'package:buysmartm/screen/utils/utils.dart';

import '../controller/signin_controller.dart';

class signin_screen extends StatefulWidget {
  const signin_screen({super.key});

  @override
  State<signin_screen> createState() => _signin_screenState();
}

class _signin_screenState extends State<signin_screen> {
  bool loading = false;
  final userController = TextEditingController();
  final passController = TextEditingController();

  bool can_continue() {
    if (userController.text.isNotEmpty && passController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 49, 127, 123),
        body: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: width/3 * 1.8,
                  height: width/3 * 1.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image/logo/yellowwhite.png'),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 35,
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    finaldata.mainLang.WelcomeBack,
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    finaldata.mainLang.Loginwithyouraccounttocontinue,
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: text_field_login(controller: userController, hint: finaldata.mainLang.Username, event: () {setState(() {});}, iconData: Icons.person,),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: text_field_login(controller: passController, hint: finaldata.mainLang.Password, event: () {setState(() {});}, iconData: Icons.lock,),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: GestureDetector(
                  child: Container(
                    height: 20,
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                      finaldata.mainLang.Forgotpassword,
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return forgot_password_dialog();
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(can_continue() ? Color.fromARGB(255, 243, 175, 74) : Colors.grey),
                    ),
                    onPressed: () async {
                      if (can_continue()) {
                        setState(() {loading = true;});
                        await signin_controller.loginHandleWeb(userController.text.toString(), passController.text.toString(),
                              () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => main_screen()),);},
                              () {setState(() {loading = false;});},);
                      } else {
                        toastMessage('Please fill all information and try again');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: !loading ? Text(
                        finaldata.mainLang.Login,
                        style: TextStyle(
                          fontFamily: 'sf',
                          color: Colors.white,
                          fontSize: width/25,
                          fontWeight: FontWeight.normal,
                        ),
                      ) : CircularProgressIndicator(color: Colors.white,),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Container(
                height: 20,
                width: width,
                alignment: Alignment.center,
                child: AutoSizeText(
                  finaldata.mainLang.donthaveaccount,
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10,),

              GestureDetector(
                child: Container(
                  height: 20,
                  width: width,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    finaldata.mainLang.registernow,
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 100,
                      color: Color.fromARGB(255, 243, 175, 74),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => signup_screen()));
                },
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => preview_screen()));
        return true;
      },
    );
  }
}
