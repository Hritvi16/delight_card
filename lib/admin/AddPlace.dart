import 'dart:io';

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

class AddPlace extends StatefulWidget {
  final String act;
  final Places? place;
  const AddPlace({Key? key, required this.act, this.place}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

enum Food {veg, nonveg}

class _AddPlaceState extends State<AddPlace> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool load = false;
  bool ignore = false;
  bool showImageError = false;

  Food food = Food.veg;

  List<PlacesType> placeTypes = [];
  List<Areas> areas = [];
  List<String> areasString = [];
  List<String> placeTypeString = [];
  List<String> areasid = [];
  late SharedPreferences sharedPreferences;
  String? area;
  String? placeType;

  final placename = TextEditingController();
  final starttime = TextEditingController();
  final endtime = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final mobile = TextEditingController();
  final tc = TextEditingController();

  File? imageFile = null;

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
                Text(
                  "Select Area",
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
                  items: areasString,
                  onChanged: (value) {
                    area = value;
                    ignore = false;
                    setState(() {});
                  },
                  selectedItem: area,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Place Type",
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
                  items: placeTypeString,
                  onChanged: (value) {
                    placeType = value;
                    ignore = false;
                    setState(() {});
                  },
                  selectedItem: placeType,
                ),
                SizedBox(
                  height: 10,
                ),
                if(placeType=="Restaurant")
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
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
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
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
                  controller: tc,
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
                SizedBox(
                  height: 20,
                ),
                widget.act==APIConstant.add ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: 100,
                            child: imageFile!=null ?
                            Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                            : Icon(
                              Icons.image,
                              color: MyColors.grey10,
                              size: 100,
                            )
                        ),
                        Visibility(
                          visible: showImageError,
                          child: Text(
                            "* Choose Image",
                            style: TextStyle(
                              color: MyColors.red
                            ),
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: Text("UPLOAD IMAGE")
                    )
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 100,
                        child: imageFile!=null ?
                        Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                        : Image.network(
                          Environment.imageUrl+(widget.place?.image??""),
                          fit: BoxFit.fill,
                        )
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: Text("CHANGE IMAGE")
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
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
                              if (formkey.currentState!.validate() && ((imageFile!=null && widget.act==APIConstant.add) || widget.act == APIConstant.update)) {
                                print("Validated");

                                print("hhh");


                                showImageError = false;
                                // ignore = true;
                                setState(() {

                                });
                                addPlace();
                              } else {
                                if(imageFile==null) {
                                  showImageError = true;
                                  setState(() {

                                  });
                                }
                                else {
                                  showImageError = false;
                                  setState(() {

                                  });
                                }
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
      ),
    );
  }

  Future<void> start() async {
    await getAreas();
    if(widget.act==APIConstant.update) {
      area = widget.place?.arName??"";
      placeType = widget.place?.placeType??"";
      placename.text = widget.place?.name??"";
      starttime.text = widget.place?.startTime??"";
      endtime.text = widget.place?.endTime??"";
      mobile.text = widget.place?.mobile??"";
      latitude.text = widget.place?.lat??"";
      longitude.text = widget.place?.longi??"";
      address.text = widget.place?.address??"";
      description.text = widget.place?.description??"";
      tc.text = widget.place?.tc??"";
      food = (widget.place?.isVeg??"1")=="1" ? Food.veg : Food.nonveg;
    }
    setState(() {

    });
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

  Future<void> getAreas() async {
    Map<String, String> queryParameters = {APIConstant.act: APIConstant.getAll};
    AreaListResponse areaListResponse =
    await APIService().getAreas(queryParameters);
    print(areaListResponse.toJson());

    areas = areaListResponse.areas ?? [];

    if (areas.length > 0) {
      areas.forEach((element) {
        areasString.add(element.name!);
      });
    }
    area = areas[0].name ?? "Select Area";
    print(area);
    if (areas.length > 0) {
      areas.forEach((element) {
        areasid.add(element.id!);
      });
    }

    await getPlacesType();
  }

  getPlacesType() async {
    Map<String, String> queryParameters = {
      APIConstant.act: APIConstant.getAll,
    };
    PlacesTypeListResponse placesTypeListResponse =
    await APIService().getPlacesType(queryParameters);
    print(
        "---------------------------------PLACESS TYEP LIST ---------------------------------");
    print(placesTypeListResponse.toJson());

    List<PlacesType> placeTypes = placesTypeListResponse.placesType ?? [];


    if (placeTypes.length > 0) {
      placeTypes.forEach((element) {
        if(element.isPlace=="1") {
          this.placeTypes.add(element);
          placeTypeString.add(element.name!);
        }
      });
    }
    print(this.placeTypes.length);
    placeType = placeTypeString.first;
    load = true;
    setState(() {});
  }

  Future<void> addPlace() async {
    Map<String, dynamic> data = new Map();
    data[APIConstant.act] = widget.act;
    data['name'] = placename.text;
    data['start_time'] = starttime.text;
    data['end_time'] = endtime.text;
    data['mobile'] = mobile.text;
    data['lat'] = latitude.text;
    data['longi'] = longitude.text;
    data['address'] = address.text;
    data['description'] = description.text;
    data['tc'] = tc.text;
    data['ar_id'] = areas[areasString.indexOf(area!)].id??"";
    data['pt_id'] = placeTypes[placeTypeString.indexOf(placeType!)].id??"";
    data['is_veg'] = food==Food.veg ? "1" : "0";
    if(imageFile!=null)
      data['places'] = imageFile?.path??"";
    if(widget.act==APIConstant.update)
      data["id"] = widget.place?.id??"";
    print(data);

    Response response = imageFile!=null ? await APIService().auPlaceF(data) : await APIService().auPlace(data);
    print(response.toJson());

    ignore = false;

    setState(() {

    });
    if(response.msg=="Success" && (response.status=="Place Added" || response.status=="Place Updated")) {
      Navigator.pop(context, "Success");
    }
    else {

      Toast.sendToast(context, response.status??"");
    }
  }
}

