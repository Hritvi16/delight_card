import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/model/StaffListResponse.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddStaff extends StatefulWidget {
  final String act;
  final Staff? staff;
  const AddStaff({Key? key, required this.act, this.staff}) : super(key: key);

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {

  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController name = TextEditingController();

  bool? passwordValidate, mobileValidate, nameValidate;
  String? passwordError, mobileError, nameError;

  List<Roles> roles = [];
  List<String> rolesString = [];
  String? role;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    passwordValidate = mobileValidate = nameValidate = false;
    passwordError = mobileError = nameError = "";

    start();
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
              Text(
                "Select Role",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                //disabledItemFn: (String s) => s.startsWith('A'),
                showSearchBox: true,
              ),
              items: rolesString,
              onChanged: (value) {
                role = value;
                ignore = false;
                setState(() {});
              },
              selectedItem: role,
            ),
              SizedBox(
                height: 10,
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
                height: 10,
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
                              addStaff();
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
  Future<void> start() async {
    await getRoles();
    if(widget.act==APIConstant.update) {
      name.text = widget.staff?.name??"";
      mobile.text = widget.staff?.phone??"";
      role = widget.staff?.role??"";
    }
    setState(() {

    });
  }

  getRoles() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    RoleListResponse roleListResponse = await APIService().getRoles(queryParameters);
    print(roleListResponse.toJson());

    roles = roleListResponse.roles ?? [];

    if(roles.length>0) {
      role = roles[0].name??"";
      roles.forEach((element) {
        rolesString.add(element.name!);
      });
    }
  }

  Future<void> addStaff() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : name.text,
      "phone" : mobile.text,
      "password" : password.text,
      "roleid" : roles[rolesString.indexOf(role!)].id??"",
      if(widget.act==APIConstant.update)
        "id" : widget.staff?.id??""
    };
    Response response = await APIService().addStaff(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    if(response.msg=="Success" && (response.status=="Staff Added" || response.status=="Staff Updated")) {
      Navigator.pop(context, "Success");
    }
    else {

      Toast.sendToast(context, response.status??"");
    }
  }
}

