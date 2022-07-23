import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/model/UsersListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddUser extends StatefulWidget {
  final String act;
  final Users? user;
  const AddUser({Key? key, required this.act, this.user}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  bool? passwordValidate, emailValidate, nameValidate;
  String? passwordError, emailError, nameError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    passwordValidate = emailValidate = nameValidate = false;
    passwordError = emailError = nameError = "";

    if(widget.act==APIConstant.update) {
      name.text = widget.user?.name??"";
      email.text = widget.user?.email??"";
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 10,
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

              TextFormField(
                controller: password,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  errorText: passwordValidate! ? passwordError : null,
                  label: Text("Password"),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String message = "";
                  if (value!.isEmpty && widget.act==APIConstant.add) {
                    return "* Required";
                  } else {
                    return null;
                  }

                },
              ),
              SizedBox(
                height: 25,
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
                              print("Validated");

                              ignore = true;
                              setState(() {

                              });
                              addUser();
                            } else {
                              print("Not Validated");
                            }
                          },
                          child: Text("Add")
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
    );
  }

  Future<void> addUser() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : name.text,
      "email" : email.text,
      "password" : password.text,
      if(widget.act==APIConstant.update)
        "id" : widget.user?.id??""
    };
    Response response = await APIService().addUser(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    Toast.sendToast(context, response.status??"");

    if(response.msg=="Success" && (response.status=="User Added" || response.status=="User Updated")) {
      Navigator.pop(context, "Success");
    }
  }
}

