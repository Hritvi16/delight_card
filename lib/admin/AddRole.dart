import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/toast/Toast.dart';


class AddRole extends StatefulWidget {
  final String act;
  final Roles? role;
  const AddRole({Key? key, required this.act, this.role}) : super(key: key);

  @override
  State<AddRole> createState() => _AddRoleState();
}

class _AddRoleState extends State<AddRole> {

  TextEditingController roleController = TextEditingController();

  bool? roleValidate;
  String? roleError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    roleValidate = false;
    roleError = "";
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
            children: [
              TextFormField(
                controller: roleController,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: roleValidate! ? roleError : null,
                  label: Text("Role"),
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
                              addRole();
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

  void start() {
    if(widget.act==APIConstant.update) {
      roleController.text = widget.role?.name??"";
    }
  }

  Future<void> addRole() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : roleController.text,
      if(widget.act==APIConstant.update)
        "id" : widget.role?.id??""
    };
    Response response = await APIService().auRole(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    if(response.msg=="Success" && (response.status=="Role Added" || response.status=="Role Updated")) {
      Navigator.pop(context, "Success");
    }
    else {

      Toast.sendToast(context, response.status??"");
    }
  }
}

