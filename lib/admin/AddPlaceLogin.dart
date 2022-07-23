import 'dart:io';

import 'package:delight_card/model/PlaceLoginResponse.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/model/AreaListResponse.dart';
import 'package:delight_card/model/PlaceListResponse.dart';
import 'package:delight_card/model/PlacesTypeListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddPlaceLogin extends StatefulWidget {
  final String id;
  const AddPlaceLogin({Key? key, required this.id}) : super(key: key);

  @override
  State<AddPlaceLogin> createState() => _AddPlaceLoginState();
}

class _AddPlaceLoginState extends State<AddPlaceLogin> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool load = false;
  bool ignore = false;

  LoginData? loginData;

  String act = "add";

  final TextEditingController username = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    start();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Place Name';
                    }
                    return null;
                  },
                  controller: username,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: 'UserName',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Mobile Time';
                    } else if (value.length!=10) {
                      return "Please Enter Valid Mobile Number";
                    }
                    return null;
                  },
                  controller: mobile,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    labelText: 'Mobile',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  // cursorColor: MyColors.colorPrimary,
                  style: TextStyle(color: Colors.black),
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
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
                    if (value!.isEmpty && act==APIConstant.act) {
                      return "* Required";
                    }  else {
                      return null;
                    }

                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IgnorePointer(
                      ignoring: ignore,
                      child: SizedBox(
                        height: 35,
                        width: 90,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                addPlaceLogin();
                              }
                            },
                            child: Text(act==APIConstant.add ? "Add" : "Update")
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      width: 90,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, "Cancel");
                          },
                          child: const Text("Cancel ")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> start() async {
    checkPlaceLogin();
  }

  Future<void> checkPlaceLogin() async {
    Map<String, String> queryParameters = {
      APIConstant.act: APIConstant.auth,
      "p_id" : widget.id
    };

    PlaceLoginResponse placeLoginResponse = await APIService().checkPlaceLogin(queryParameters);
    print(placeLoginResponse.toJson());

    if(placeLoginResponse.status=="Available") {
      act = "add";
    }
    else {
      loginData = placeLoginResponse.loginData ?? LoginData();
      act = "update";

      username.text = loginData?.pUsername??"";
      mobile.text = loginData?.pMobile??"";
    }

    load = true;
    setState(() {

    });
  }

  Future<void> addPlaceLogin() async {
    Map<String, dynamic> data = new Map();
    data[APIConstant.act] = act==APIConstant.add ? "adduser" : "updateuser";
    data['p_id'] = widget.id;
    data['username'] = username.text;
    data['mobile'] = mobile.text;
    data['password'] = password.text;

    print(data);

    Response response = await APIService().auPlaceLogin(data);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    if(response.msg=="Success" && (response.status=="Place Login Added" || response.status=="Place Login Updated")) {
      Navigator.pop(context, "Success");
    }
    else {

      Toast.sendToast(context, response.status??"");
    }
  }
}

