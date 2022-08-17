import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/size/MySize.dart';
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
                Container(
                  width: MySize.size100(context),
                  color: MyColors.white,
                  child: Image.asset(
                    "assets/logo/company_logo.JPG",
                    height: MySize.sizeh25(context),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shadowColor: Colors.grey,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
