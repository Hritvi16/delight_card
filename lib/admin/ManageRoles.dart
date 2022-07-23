import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/AccessListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StaffListResponse.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';
import '../model/UserAccessListResponse.dart';

class ManageRoles extends StatefulWidget {
  final Staff staff;
  const ManageRoles({Key? key, required this.staff}) : super(key: key);

  @override
  State<ManageRoles> createState() => _ManageRolesState();
}

class _ManageRolesState extends State<ManageRoles> {

  bool ignore = false;
  List<Access> accesses = [];
  List<UserAccess> userAccesses = [];

  // late SharedPreferences sharedPreferences;

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
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      )
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("C",
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        )
                      )
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("U",
                            style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          )
                      )
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("R",
                            style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          )
                      )
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("D",
                            style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          )
                      )
                  ),
                ],
              ),
              Container(
                height: MySize.sizeh60(context),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.separated(
                  itemCount: userAccesses.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return getAccessDesign(index);
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                ),
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
                            // if (formkey.currentState!.validate()) {
                            //   print("Validated");
                            //
                              ignore = true;
                              setState(() {

                              });
                              manageRoles();
                            // } else {
                            //   print("Not Validated");
                            // }
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
    );
  }

  Widget getAccessDesign(int ind) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(userAccesses[ind].access??"")
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Checkbox(
            value: userAccesses[ind].c=="0" ? false : true,
            onChanged: (value) {
              print(value);
              userAccesses[ind].c = (value==true ? "1" : "0");

              ignore = false;
              setState(() {

              });
            }
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Checkbox(
            value: userAccesses[ind].u=="0" ? false : true,
            onChanged: (value) {
              print(value);
              userAccesses[ind].u = (value==true ? "1" : "0");
              setState(() {

              });
            }
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Checkbox(
            value: userAccesses[ind].r=="0" ? false : true,
            onChanged: (value) {
              print(value);
              userAccesses[ind].r = (value==true ? "1" : "0");
              setState(() {

              });
            }
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Checkbox(
              value: userAccesses[ind].d=="0" ? false : true,
              onChanged: (value) {
                print(value);
                userAccesses[ind].d = (value==true ? "1" : "0");
                setState(() {

                });
              }
          ),
        ),
      ],
    );
  }

  Future<void> start() async {
    // sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

    });
    getAccess();
  }

  getAccess() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    AccessListResponse accessListResponse = await APIService().getAccess(queryParameters);
    print(accessListResponse.toJson());

    accesses = accessListResponse.access ?? [];
    getUserAccess();
  }

  getUserAccess() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByAID,
      "id" : widget.staff?.id??""
    };
    UserAccessListResponse userAccessListResponse = await APIService().getUserAccess(queryParameters);
    print(userAccessListResponse.toJson());

    userAccesses = userAccessListResponse.userAccess ?? [];

    setState(() {

    });
  }

  Future<void> manageRoles() async {
    Map<String,dynamic> queryParameters = {
      APIConstant.act : APIConstant.add,
      "id" : widget.staff?.id??"",
      "user_access" : getUserAccessList().toString()
    };
    print(queryParameters);
    Response response = await APIService().manageUserAccess(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    Toast.sendToast(context, response.status??"");

    if(response.msg=="Success" && response.status=="Access Managed") {
      Navigator.pop(context, "Success");
    }
  }

  getUserAccessList() {
    // List<Map<String, dynamic>> list = [];
    String list = userAccesses.map((userAccess) {
      String map= "{";
      map+='"id":"${userAccess.id??""}", ' ;
      map+='"access":"${userAccess.access??""}", ' ;
      map+='"uid":"${userAccess.uid??""}", ' ;
      map+='"c":"${userAccess.c??""}", ' ;
      map+='"u":"${userAccess.u??""}", ' ;
      map+='"r":"${userAccess.r??""}", ' ;
      map+='"d":"${userAccess.d??""}"}' ;
      return map;
    }).join(',,');
    // userAccesses.forEach((element) {
    //   list.add(element.toJson());
    // });
    return list;
  }
}

