import 'package:delight_card/model/PlaceLoginResponse.dart';
import 'package:delight_card/staff/StaffLogin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Home.dart';
import 'package:delight_card/admin/AdminLogin.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/AreaList.dart';
import 'package:delight_card/customer/Login.dart';
import 'package:delight_card/model/LoginResponse.dart';
import 'package:delight_card/toast/Toast.dart';
import 'package:delight_card/size/MySize.dart';

import '../model/StaffLoginResponse.dart';

class PlaceLogin extends StatefulWidget {
  const PlaceLogin({Key? key}) : super(key: key);

  @override
  State<PlaceLogin> createState() => _PlaceLoginState();
}


class _PlaceLoginState extends State<PlaceLogin> {

  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool? passwordValidate, usernameValidate;
  String? passwordError, usernameError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;
  bool passwordVisible = false;

  @override
  void initState() {
    passwordValidate = usernameValidate = false;
    passwordError = usernameError = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              height: MySize.sizeh100(context),
              padding: EdgeInsets.symmetric(horizontal: MySize.size7(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MySize.sizeh30(context),
                  ),
                  Text(
                    "Partner Login",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: MySize.sizeh5(context),
                  ),
                  TextFormField(
                    controller: username,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: usernameValidate! ? usernameError : null,
                      label: Text("Username"),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      String message = "";
                      if (value!.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }

                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh1(context),
                  ),
                  TextFormField(
                    controller: password,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      errorText: passwordValidate! ? passwordError : null,
                      label: Text("Password"),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          // color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      String message = "";
                      if (value!.isEmpty) {
                        return "* Required";
                      }  else {
                        return null;
                      }

                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh3(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Login as ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: "Admin",
                                    style: TextStyle(
                                        color: MyColors.colorPrimary
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminLogin()));
                                    },
                                  )
                                ]
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Login as ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: "Customer",
                                    style: TextStyle(
                                        color: MyColors.colorPrimary
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                  )
                                ]
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Login as ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: "Staff",
                                    style: TextStyle(
                                        color: MyColors.colorPrimary
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StaffLogin()));
                                    },
                                  )
                                ]
                            ),

                          ),
                        ],
                      ),
                      IgnorePointer(
                        ignoring: ignore,
                        child: FloatingActionButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              print("Validated");

                              ignore = true;
                              setState(() {

                              });
                              login();
                            } else {
                              print("Not Validated");
                            }
                          },
                          child: Icon(
                              Icons.arrow_forward
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    print("Login");
    Map<String, dynamic> data = new Map();
    data['username'] = username.text;
    data['password'] = password.text;
    data.addAll({APIConstant.act : APIConstant.login});
    PlaceLoginResponse placeLoginResponse = await APIService().placeLogin(data);
    print(placeLoginResponse.toJson());

    ignore = false;
    setState(() {

    });
    Toast.sendToast(context, placeLoginResponse.msg??"");

    if(placeLoginResponse.status=="Success" && placeLoginResponse.msg=="Logged In") {
      print(placeLoginResponse.loginData?.pId);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


      sharedPreferences!.setString("login_type", "place_login");
      sharedPreferences!.setString("id", placeLoginResponse.loginData?.pId??"");
      sharedPreferences!.setString("username", username.text);
      sharedPreferences!.setString("status", "logged in");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Home()),
              (Route<dynamic> route) => false);
    }
  }

}
