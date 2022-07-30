import 'package:delight_card/strings/Strings.dart';
import 'package:flutter/material.dart';

class TC extends StatelessWidget {
  const TC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Terms & Condition",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Strings.tc,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
