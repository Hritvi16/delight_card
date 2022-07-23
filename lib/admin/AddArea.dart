import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/AreaListResponse.dart';
import 'package:delight_card/model/CityListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../colors/MyColors.dart';

class AddArea extends StatefulWidget {
  final String act;
  final Areas? area;
  const AddArea({Key? key, required this.act, this.area}) : super(key: key);

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> {


  TextEditingController areaController = TextEditingController();

  bool? areaValidate;
  String? areaError;

  List<States> states = [];
  List<String> statesString = [];
  String? state;

  List<Cities> cities = [];
  List<String> citiesString = [];
  String? city;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  @override
  void initState() {
    areaValidate = false;
    areaError = "";
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
              onChanged: (value) async {
                state = value;
                await getCities(states[statesString.indexOf(value!)].id??"");
                ignore = false;
                setState(() {});
              },
              selectedItem: state,
            ),
              SizedBox(
                height: 10,
              ),

              Text(
                "Select City",
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
                items: citiesString,
                onChanged: (value) {
                  city = value;
                  ignore = false;
                  setState(() {});
                },
                selectedItem: city,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: areaController,
                // cursorColor: MyColors.colorPrimary,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  errorText: areaValidate! ? areaError : null,
                  label: Text("Area"),
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
                              addArea();
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
    await getStates();
    if(widget.act==APIConstant.update) {
      areaController.text = widget.area?.name??"";
      state = widget.area?.sName??"";
      city = widget.area?.cName??"";
    }
    setState(() {

    });
  }

  getStates() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    StateListResponse stateListResponse = await APIService().getStates(queryParameters);
    print(stateListResponse.toJson());

    states = stateListResponse.states ?? [];

    if(states.length>0) {
      state = states[0].name??"";
      getCities(states[0].id??"");
      states.forEach((element) {
        statesString.add(element.name!);
      });
    }
  }

  Future<void> getCities(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : id
    };
    CityListResponse cityListResponse = await APIService().getCities(queryParameters);
    print(cityListResponse.toJson());

    cities = cityListResponse.cities ?? [];
    citiesString = [];
    if(cities.length>0) {
      city = cities[0].name??"";
      cities.forEach((element) {
        citiesString.add(element.name!);
      });
    }
    setState(() {

    });
  }

  Future<void> addArea() async {
    print(city);
    print(citiesString);
    print(citiesString.indexOf(city!));
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "name" : areaController.text,
      "c_id" : cities[citiesString.indexOf(city!)].id??"",
      if(widget.act==APIConstant.update)
        "id" : widget.area?.id??""
    };
    Response response = await APIService().auArea(queryParameters);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    if(response.msg=="Success" && (response.status=="Area Added" || response.status=="Area Updated")) {
      Navigator.pop(context, "Success");
    }
    else {

      Toast.sendToast(context, response.status??"");
    }
  }
}

