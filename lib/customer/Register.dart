import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';
import 'Login.dart';
import '../api/APIConstant.dart';
import '../api/APIService.dart';
import '../model/CityListResponse.dart';
import '../size/MySize.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {

  TextEditingController cpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController name = TextEditingController();

  bool? cpasswordValidate,  passwordValidate,  pincodeValidate, addressValidate, mobileValidate, nameValidate;
  String? cpasswordError,    passwordError,    pincodeError,   addressError,  mobileError, nameError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<Cities> cities = [];
  List<String> citiesString = [];
  String? city;

  bool ignore = false;
  bool passwordVisible = false;
  bool cpasswordVisible = false;

  @override
  void initState() {
    cpasswordValidate = passwordValidate = pincodeValidate = addressValidate = mobileValidate = nameValidate = false;
    cpasswordError = passwordError = pincodeError = addressError = mobileError = nameError = "";

    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Container(
            height: MySize.sizeh100(context),
            padding: EdgeInsets.symmetric(horizontal: MySize.size7(context)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MySize.sizeh3(context),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: MySize.sizeh5(context),
                  ),
                  TextFormField(
                    controller: name,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: nameValidate! ? nameError : null,
                      label: Text("Name"),
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
                    height: MySize.sizeh05(context),
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
                    height: MySize.sizeh3(context),
                  ),
                  Text(
                    "Select City",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  SizedBox(
                    height: MySize.sizeh05(context),
                  ),
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      //disabledItemFn: (String s) => s.startsWith('A'),
                      showSearchBox: true,
                    ),
                    items: citiesString,
                    onChanged: (value) {
                      city = value;
                      ignore = false;
                      setState(() {});
                    },
                    selectedItem: city,
                  ),
                  SizedBox(
                    height: MySize.sizeh05(context),
                  ),
                  TextFormField(
                    controller: address,
                    // cursorColor: MyColors.colorPrimary,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: addressValidate! ? addressError : null,
                      label: Text("Address"),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh05(context),
                  ),
                  TextFormField(
                    controller: pincode,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: pincodeValidate! ? pincodeError : null,
                      label: Text("Pincode"),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh05(context),
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
                      } else if (value!=cpassword.text) {
                        return "* Password doesn't match";
                      } else {
                        return null;
                      }

                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh05(context),
                  ),
                  TextFormField(
                    controller: cpassword,
                    // cursorColor: MyColors.colorPrimary,
                    style: TextStyle(color: Colors.black),
                    obscureText: !cpasswordVisible,
                    decoration: InputDecoration(
                      errorText: cpasswordValidate! ? cpasswordError : null,
                      label: Text("Confirm Password"),
                      suffixIcon: IconButton(
                        icon: Icon(
                          cpasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          // color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            cpasswordVisible = !cpasswordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      String message = "";
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value!=password.text) {
                        return "* Password doesn't match";
                      } else {
                        return null;
                      }

                    },
                  ),
                  SizedBox(
                    height: MySize.sizeh3(context),
                  ),
                  IgnorePointer(
                    ignoring: ignore,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          print(":hellu");
                          if (formkey.currentState!.validate()) {
                            print("Validated");

                            ignore = true;
                            setState(() {

                            });
                            register();
                          } else {
                            print("Not Validated");
                          }
                        },
                        child: Icon(
                            Icons.arrow_forward
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MySize.sizeh10(context),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style:
                            TextStyle(color: Colors.black, fontSize: MySize.font14(context)),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: MyColors.colorPrimary, fontSize: MySize.font14(context)
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                              ),
                            ])),
                  ),

                  SizedBox(
                    height: MySize.sizeh3(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> start() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    CityListResponse cityListResponse = await APIService().getCities(queryParameters);
    print(cityListResponse.toJson());

    cities = cityListResponse.cities ?? [];

    cities.forEach((element) {
      citiesString.add(element.name!);
    });

    setState(() {

    });
  }


  void register() async {
    Map<String, dynamic> data = new Map();
    data['name'] = name.text;
    data['phone'] = mobile.text;
    data['password'] = password.text;
    data['cityid'] = cities[citiesString.indexOf(city!)].id;
    data['address'] = address.text;
    data['pincode'] = pincode.text;
    data.addAll({APIConstant.act : APIConstant.add});
    print(data);
    Response response = await APIService().signUp(data);
    print(response.toJson());

    ignore = false;
    setState(() {

    });
    Toast.sendToast(context, response.msg??"");

    if(response.status=="Success" && response.msg=="Customer Added") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const Login()),
              (Route<dynamic> route) => false);
    }
  }

}
