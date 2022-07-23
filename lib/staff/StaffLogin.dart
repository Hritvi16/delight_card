import 'package:delight_card/place/PlaceLogin.dart';
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

class StaffLogin extends StatefulWidget {
  const StaffLogin({Key? key}) : super(key: key);

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}


class _StaffLoginState extends State<StaffLogin> {

  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();

  bool? passwordValidate, mobileValidate;
  String? passwordError, mobileError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;
  bool passwordVisible = false;

  @override
  void initState() {
    passwordValidate = mobileValidate = false;
    passwordError = mobileError = "";

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
                    "Staff Login",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: MySize.sizeh5(context),
                  ),
                  TextFormField(
                    controller: mobile,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: mobileValidate! ? mobileError : null,
                      label: Text("Mobile No."),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      String message = "";
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value!.length<10) {
                        return "* Incorrect Mobile No.";
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
                                    text: "Owner",
                                    style: TextStyle(
                                        color: MyColors.colorPrimary
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PlaceLogin()));
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
    data['mobile'] = mobile.text;
    data['password'] = password.text;
    data.addAll({APIConstant.act : APIConstant.login});
    StaffLoginResponse staffLoginResponse = await APIService().staffLogin(data);
    print(staffLoginResponse.toJson());

    ignore = false;
    setState(() {

    });
    Toast.sendToast(context, staffLoginResponse.msg??"");

    if(staffLoginResponse.status=="Success" && staffLoginResponse.msg=="Logged In") {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


      sharedPreferences!.setString("login_type", "staff");
      sharedPreferences!.setString("id", staffLoginResponse.data?.id??"");
      sharedPreferences!.setString("name", staffLoginResponse.data?.name??"");
      sharedPreferences!.setString("code", staffLoginResponse.data?.code??"");
      sharedPreferences!.setString("role", staffLoginResponse.data?.roleid??"");
      sharedPreferences!.setString("ar_id", "1");
      sharedPreferences!.setString("mobile", mobile.text);
      sharedPreferences!.setString("status", "logged in");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Home()),
              (Route<dynamic> route) => false);
    }
  }

}
