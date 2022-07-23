import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/CardListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';
import 'dart:math' as math;

class AddCard extends StatefulWidget {
  final String act;
  final Customers? card;
  const AddCard({Key? key, required this.act, this.card}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

  TextEditingController agent = TextEditingController();
  TextEditingController secret = TextEditingController();

  bool? agentValidate, secretValidate;
  String? agentError, secretError;

  late String act;
  Customers? card;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    agentValidate = secretValidate = false;
    agentError = secretError = "";

    act = widget.act;
    card = widget.card;
    start();
    // if(widget.act==APIConstant.update) {
    //   secret.text = widget.user?.secret??"";
    //   email.text = widget.user?.email??"";
    // }
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
                controller: agent,
                readOnly: act==APIConstant.add ? false : true,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: agentValidate! ? agentError : null,
                  label: Text("Agent ID"),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  String message = "";
                  if (value!.isEmpty && act==APIConstant.add) {
                    return "* Required";
                  } else {
                    return null;
                  }

                },
              ),
              if(card!=null)
                SizedBox(
                  height: 10,
                ),
              if(card!=null)
                TextFormField(
                  controller: secret,
                  obscureText: true,
                  maxLength: 6,
                  // cursorColor: MyColors.colorPrimary,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    errorText: secretValidate! ? secretError : null,
                    label: Text("Secret Code"),
                  ),
                  keyboardType: TextInputType.number,
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
                              addCard();
                            } else {
                              print("Not Validated");
                            }
                          },
                          child: Text(card==null ? "Add" : "Apply")
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

  Future<void> addCard() async {
    int secret = generateSecretCode();
    Map<String,String> queryParameters = {
      "id" : act==APIConstant.add ? sharedPreferences.getString("id")??"" : card?.id??"",
      APIConstant.act : act,
      "secret" : act==APIConstant.add ? secret.toString() : this.secret.text,
      if(act==APIConstant.add)
        "agent" : agent.text,
    };
    print(queryParameters);
    ApplyCardResponse applyCardResponse = await APIService().addCard(queryParameters);
    print(applyCardResponse.toJson());

    ignore = false;

    Toast.sendToast(context, applyCardResponse.status??"");

    if(applyCardResponse.msg=="Success") {
      if(applyCardResponse.status=="Card Added") {
        act = "update";
        card = applyCardResponse.card??null;
      }
      if(applyCardResponse.status=="Card Updated") {
        Navigator.pop(context, "Success");
      }
    }

    setState(() {

    });
  }

  generateSecretCode() {
    var rnd = new math.Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    print(next.toInt());
    return next.toInt();
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(act==APIConstant.update)
      agent.text = card?.agent??"";
  }
}

