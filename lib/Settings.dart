import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/LoginPopUp.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/Login.dart';

import 'size/MySize.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences sharedPreferences;
  bool load = false;

  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? Container(
        width: MySize.size100(context),
        height: MySize.sizeh100(context),
        padding: EdgeInsets.symmetric(vertical: MySize.sizeh2(context), horizontal: MySize.size1(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MySize.size35(context),
                  width: MySize.size35(context),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: MySize.size5(context)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.colorPrimary
                  ),
                  // child: Text(
                  //   (sharedPreferences.getString("name")??" ").substring(0,1).toUpperCase(),
                  //   style: TextStyle(
                  //       color: MyColors.white,
                  //       fontSize: 28
                  //   ),
                  // ),
                  child: Icon(
                    Icons.person,
                    color: MyColors.white,
                    size: 55,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Username: "+(sharedPreferences.getString("username")??""),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if((sharedPreferences.getString("login_type")??"")=="staff")
                  Text(
                    "MY CODE: "+(sharedPreferences.getString("code")??""),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                    ),
                  ),
              ],
            ),
            TextButton(
              onPressed: () {
                loginPopUp();
              },
              child: Text(
                  "LOGOUT",
                style: TextStyle(
                  color: MyColors.white
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.colorPrimary),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40))
              ),
            ),
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    load = true;
    setState(() {

    });
  }

  loginPopUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return LoginPopUp(
          text: "Are you sure you want to logout?",
          btn1 : "Cancel",
          btn2: "Logout",
        );
      },
    ).then((value) {
      if(value=="Logout")
        logout();
    });
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences!.setString("login_type", "");
    sharedPreferences!.setString("id", "");
    sharedPreferences!.setString("name", "");
    sharedPreferences!.setString("role", "");
    sharedPreferences!.setString("ar_id", "-1");
    sharedPreferences!.setString("mobile", "");
    sharedPreferences!.setString("status", "logged out");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const Login()),
            (Route<dynamic> route) => false);
  }
}
