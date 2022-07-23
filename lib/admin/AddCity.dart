import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/CityListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddCity extends StatefulWidget {
  final String act;
  final Cities? city;
  const AddCity({Key? key, required this.act, this.city}) : super(key: key);

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {


  TextEditingController cityController = TextEditingController();

  bool? cityValidate;
  String? cityError;

  List<States> states = [];
  List<String> statesString = [];
  String? state;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    cityValidate = false;
    cityError = "";
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
                "Select State",
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
              items: statesString,
              onChanged: (value) {
                state = value;
                ignore = false;
                setState(() {});
              },
              selectedItem: state,
            ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: cityController,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: cityValidate! ? cityError : null,
                  label: Text("City"),
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
                              addCity();
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

  start() async {
    await getStates();
    if(widget.act==APIConstant.update) {
      cityController.text = widget.city?.name??"";
      state = widget.city?.sName??"";
    }
    setState(() {

    });
  }

  Future<void> getStates() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    StateListResponse stateListResponse = await APIService().getStates(queryParameters);
    print(stateListResponse.toJson());

    states = stateListResponse.states ?? [];

    if(states.length>0) {
      state = states[0].name??"";
      states.forEach((element) {
        statesString.add(element.name!);
      });
    }
    setState(() {

    });
  }
  
  Future<void> addCity() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : cityController.text,
      "s_id" : states[statesString.indexOf(state!)].id??"",
      if(widget.act==APIConstant.update)
        "id" : widget.city?.id??""
    };
    Response response = await APIService().auCity(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    Toast.sendToast(context, response.status??"");

    if(response.msg=="Success" && (response.status=="City Added" || response.status=="City Updated")) {
      Navigator.pop(context, "Success");
    }
  }
}

