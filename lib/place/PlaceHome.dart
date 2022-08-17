import 'dart:io';

import 'package:delight_card/model/PlaceListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/UserAccessListResponse.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/strings/Strings.dart';

class PlaceHome extends StatefulWidget {
  const PlaceHome({Key? key}) : super(key: key);

  @override
  State<PlaceHome> createState() => _PlaceHomeState();
}

enum Food {veg, nonveg, both}

class _PlaceHomeState extends State<PlaceHome> {
  late SharedPreferences sharedPreferences;
  bool load = false;
  Places place = Places();
  bool ignore = false;
  bool showImageError = false;

  Food food = Food.veg;

  final area = TextEditingController();
  final placetype = TextEditingController();
  final placename = TextEditingController();
  final starttime = TextEditingController();
  final endtime = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController();
  final speciality = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final mobile = TextEditingController();
  final tc = TextEditingController();

  File? imageFile = null;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        backgroundColor: MyColors.grey1.withOpacity(0.5),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 2.0,
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          Environment.imageUrl + (place.image ?? ""),
                          fit: BoxFit.fill,
                          height: 200,
                          width: MediaQuery.of(context).size.width
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 20,
                  ),
                  TextFormField(
                    controller: area,
                    enabled: false,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on),
                      labelText: 'Area',
                    ),
                  ),
                  TextFormField(
                    controller: placetype,
                    enabled: false,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.account_balance),
                      labelText: 'Area',
                    ),
                  ),
                  if(place.placeType=="Restaurant")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: Food.veg,
                              groupValue: food,
                              onChanged: (Food? value) {
                                setState(() {
                                  food = value!;
                                });
                              },
                            ),
                            Text(
                              "Veg",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Food.nonveg,
                              groupValue: food,
                              onChanged: (Food? value) {
                                setState(() {
                                  food = value!;
                                });
                              },
                            ),
                            Text(
                              "Non-Veg",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Food.both,
                              groupValue: food,
                              onChanged: (Food? value) {
                                setState(() {
                                  food = value!;
                                });
                              },
                            ),
                            Text(
                              "Both",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Place Name';
                      }
                      return null;
                    },
                    controller: placename,
                    enabled: false,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.add_business),
                      labelText: 'Place Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Start Time';
                      }
                      return null;
                    },
                    controller: starttime,
                    enabled: false,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_clock),
                      labelText: 'Start Time',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter End Time';
                      }
                      return null;
                    },
                    controller: endtime,
                    enabled: false,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock_clock),
                      labelText: 'End Time',
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
                    enabled: false,
                    readOnly: true,
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
                    controller: latitude,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Latitude';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.map),
                      labelText: 'Latitude',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: longitude,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Longitude';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      icon: const Icon(Icons.map),
                      labelText: 'Longitude',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: address,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Address';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.location_on_outlined),
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: description,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Description';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.note),
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: speciality,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please Enter Speciality';
                      // }
                      return null;
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.star),
                      labelText: 'Speciality',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tc,
                    enabled: false,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Terms & Conditions';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.description_outlined),
                      labelText: 'Terms & Conditions',
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //         height: 100,
                  //         child: imageFile!=null ?
                  //         Image.file(
                  //           imageFile!,
                  //           fit: BoxFit.cover,
                  //         )
                  //             : Image.network(
                  //           Environment.imageUrl+(place?.image??""),
                  //           fit: BoxFit.fill,
                  //         )
                  //     ),
                  //     ElevatedButton(
                  //         onPressed: () {
                  //           _getFromGallery();
                  //         },
                  //         child: Text("CHANGE IMAGE")
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     IgnorePointer(
                  //       ignoring: ignore,
                  //       child: SizedBox(
                  //         height: 35,
                  //         width: 90,
                  //         child: ElevatedButton(
                  //             onPressed: () {
                  //               if (formkey.currentState!.validate()) {
                  //                 print("Validated");
                  //
                  //                 print("hhh");
                  //
                  //
                  //                 showImageError = false;
                  //                 // ignore = true;
                  //                 setState(() {
                  //
                  //                 });
                  //                 addPlace();
                  //               }
                  //             },
                  //             child: Text("Update")
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 35,
                  //       width: 90,
                  //       child: ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.pop(context, "Cancel");
                  //           },
                  //           child: const Text("Cancel ")),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getPlaceDetails();
  }

  _getFromGallery() async {
    checkPermission();
  }

  Future<void> checkPermission() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    // ].request();
    bool value = await Permission.storage.request().isGranted;
    if (value) {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (photo != null) {
        setState(() {
          imageFile = File(photo.path);
        });
      }
    }
  }

  getPlaceDetails() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : sharedPreferences.getString("id")??""
    };

    PlaceResponse placeResponse = await APIService().getPlaceDetails(queryParameters);
    print(placeResponse.toJson());

    place = placeResponse.places ?? Places();

    area.text = place?.arName??"";
    placetype.text = place?.placeType??"";
    placename.text = place?.name??"";
    starttime.text = place?.startTime??"";
    endtime.text = place?.endTime??"";
    mobile.text = place?.mobile??"";
    latitude.text = place?.lat??"";
    longitude.text = place?.longi??"";
    address.text = place?.address??"";
    description.text = place?.description??"";
    speciality.text = place?.speciality??"";
    tc.text = place?.tc??"";
    food = (place?.isVeg??"0")=="1" ? Food.veg : (place?.isVeg??"0")=="0" ? Food.nonveg : Food.both;

    load = true;

    setState(() {

    });
  }

  Future<void> addPlace() async {
    Map<String, dynamic> data = new Map();
    data[APIConstant.act] = APIConstant.update;
    data['name'] = placename.text;
    data['start_time'] = starttime.text;
    data['end_time'] = endtime.text;
    data['mobile'] = mobile.text;
    data['lat'] = latitude.text;
    data['longi'] = longitude.text;
    data['address'] = address.text;
    data['description'] = description.text;
    data['tc'] = tc.text;
    data['ar_id'] = place.arId;
    data['pt_id'] = place.ptId;
    data['is_veg'] = food==Food.veg ? "1" : "0";
    if(imageFile!=null)
      data['places'] = imageFile?.path??"";
    data["id"] = place?.id??"";
    print(data);

    Response response = imageFile!=null ? await APIService().auPlaceF(data) : await APIService().auPlace(data);
    print(response.toJson());

    ignore = false;

    setState(() {

    });

    Toast.sendToast(context, response.status??"");
  }
}
