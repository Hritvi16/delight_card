import 'package:delight_card/place/PlaceLogin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Home.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/Login.dart';
import 'package:delight_card/model/AdminLoginResponse.dart';
import 'package:delight_card/staff/StaffLogin.dart';
import 'package:delight_card/toast/Toast.dart';
import '../api/APIConstant.dart';
import '../api/APIService.dart';
import 'package:delight_card/size/MySize.dart';
import '../customer/Register.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}


class _AdminLoginState extends State<AdminLogin> {

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  bool? passwordValidate, emailValidate;
  String? passwordError, emailError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;
  bool passwordVisible = false;

  @override
  void initState() {
    passwordValidate = emailValidate = false;
    passwordError = emailError = "";

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
              // margin: EdgeInsets.only(top: MySize.sizeh30(context)),
              padding: EdgeInsets.symmetric(horizontal: MySize.size7(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MySize.sizeh30(context),
                  ),
                  Text(
                    "Admin Login",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: MySize.sizeh5(context),
                  ),
                  TextFormField(
                    controller: email,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: emailValidate! ? emailError : null,
                      label: Text("Email ID"),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      String message = "";
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (!EmailValidator.validate(value)) {
                        return "Enter valid email address";
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
                                    text: "Partner",
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
    Map<String, dynamic> data = new Map();
    data['email'] = email.text;
    data['password'] = password.text;
    data.addAll({APIConstant.act : APIConstant.login});
    print(data);
    AdminLoginResponse adminLoginResponse = await APIService().adminLogin(data);
    print(adminLoginResponse.toJson());

    ignore = false;
    setState(() {

    });
    Toast.sendToast(context, adminLoginResponse.msg??"");

    if(adminLoginResponse.status=="Success" && adminLoginResponse.msg=="Logged In") {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


      sharedPreferences!.setString("login_type", "admin");
      sharedPreferences!.setString("id", adminLoginResponse.data?.id??"");
      sharedPreferences!.setString("name", adminLoginResponse.data?.name??"");
      sharedPreferences!.setString("ar_id", "1");
      sharedPreferences!.setString("email", email.text);
      sharedPreferences!.setString("status", "logged in");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Home()),
              (Route<dynamic> route) => false);
    }
  }

}
