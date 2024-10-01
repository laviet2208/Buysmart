import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../data/finaldata.dart';

class wallet_appbar extends StatefulWidget {
  const wallet_appbar({super.key});

  @override
  State<wallet_appbar> createState() => _wallet_appbarState();
}

class _wallet_appbarState extends State<wallet_appbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  finaldata.mainLang.YourWallet,
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 100,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
