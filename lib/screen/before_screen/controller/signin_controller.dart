import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/finaldata.dart';
import '../../utils/utils.dart';
import 'loading_controller.dart';

class signin_controller {
  static Future<void> loginHandle(String email, String password, VoidCallback successEvent, VoidCallback failEvent) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        bool check = await Loading_Controller.checkAccountData(email);
        if (check) {
          finaldata.account = await Loading_Controller.getAccountData(email);
          if (finaldata.account.lockstatus == 1) {
            successEvent();
          } else {
            failEvent();
            toastMessage('Your account has been locked');
          }
        } else {
          failEvent();
          toastMessage('Please check your email and password');
        }
      } else {
        failEvent();
        toastMessage('Please verify your email before logging in.');
        // You can also send a verification email again if needed
        if (user != null) {
          await user.sendEmailVerification();
        }
      }
    } catch (error) {
      failEvent();
      toastMessage(error.toString());
      print(error.toString());
    }
  }

  static Future<void> loginHandleWeb(String email, String password, VoidCallback successEvent, VoidCallback failEvent) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        finaldata.account = await Loading_Controller.getAccountData(email);
        if (finaldata.account.id != '') {
          if (finaldata.account.lockstatus == 1) {
            successEvent();
          } else {
            failEvent();
            toastMessage('Your account has been locked');
          }
        } else {
          failEvent();
          toastMessage('Please check your email and password');
        }
      } else {
        failEvent();
        toastMessage('Please verify your email before logging in.');
        // You can also send a verification email again if needed
        if (user != null) {
          await user.sendEmailVerification();
        }
      }
    } catch (error) {
      failEvent();
      toastMessage(error.toString());
      print(error.toString());
    }
  }

}