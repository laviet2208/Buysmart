import 'package:buysmartm/data/MoneyRequest/MoneyRequest.dart';
import 'package:flutter/material.dart';

class enter_email_and_password extends StatefulWidget {
  final MoneyRequest moneyRequest;
  const enter_email_and_password({super.key, required this.moneyRequest});

  @override
  State<enter_email_and_password> createState() => _enter_email_and_passwordState();
}

class _enter_email_and_passwordState extends State<enter_email_and_password> {
  bool loading = false;
  TextEditingController moneyController = TextEditingController();
  TextEditingController WalletaddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
