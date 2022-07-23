import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddState extends StatefulWidget {
  final String act;
  final States? state;
  const AddState({Key? key, required this.act, this.state}) : super(key: key);

  @override
  State<AddState> createState() => _AddStateState();
}

class _AddStateState extends State<AddState> {

  TextEditingController stateController = TextEditingController();

  bool? stateValidate;
  String? stateError;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    stateValidate = false;
    stateError = "";
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
                controller: stateController,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: stateValidate! ? stateError : null,
                  label: Text("State"),
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
                              addState();
                            } else {
                              print("Not Validated");
                            }
                          },
                          child: Text(widget.act==APIConstant.add ? "Add" : "Update")
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
      stateController.text = widget.state?.name??"";
    }
  }

  Future<void> addState() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : stateController.text,
      if(widget.act==APIConstant.update)
        "id" : widget.state?.id??""
    };
    Response response = await APIService().auState(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    Toast.sendToast(context, response.status??"");

    if(response.msg=="Success" && (response.status=="State Added" || response.status=="State Updated")) {
      Navigator.pop(context, "Success");
    }
  }
}

