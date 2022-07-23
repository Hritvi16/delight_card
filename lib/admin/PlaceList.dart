import 'package:delight_card/admin/AddPlaceLogin.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/admin/AddPlace.dart';
import 'package:delight_card/customer/AreaList.dart';
import 'package:delight_card/customer/PlaceDetails.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/PlaceListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  bool load = false;
  List<Places> places = [];
  late SharedPreferences sharedPreferences;

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load ? Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
      ),
      floatingActionButton: sharedPreferences.getString("c")=="1" ? FloatingActionButton(
        onPressed: () {
          addPlace(APIConstant.add, null);
        },
        child: Icon(
            Icons.add
        ),
      ) : null,
      body: load ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                searchPlaces();
              },
              controller: search,
              // cursorColor: MyColors.colorPrimary,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  label: Text("Search Place"),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  // suffixIcon: GestureDetector(
                  //   onTap: () {
                  //     searchPlaces();
                  //   },
                  //   child: Icon(
                  //       Icons.arrow_forward
                  //   ),
                  // )
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
              height: MySize.sizeh2(context),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: places.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, index) {
                  return getPlaceCard(places[index]);
                },
              ),
            ),
          ],
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    )
    : Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getPlaceCard(Places place) {
    return SwipeActionCell(
      key: ValueKey(place),
      trailingActions: <SwipeAction>[
        if(sharedPreferences.getString("d")=="1")
          SwipeAction(
              onTap: (CompletionHandler handler) async {
                await handler(true);
                places.remove(place);
                deletePlace(place.id??"");
              },
              icon: Icon(
                Icons.delete,
                color: MyColors.white,
              ),
              color: Colors.red
          ),
        if(sharedPreferences.getString("u")=="1")
          SwipeAction(
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("edit");
              addPlace(APIConstant.update, place);
              // states.remove(state);
              // list.removeAt(index);
              // setState(() {});
            },
            icon: Icon(
              Icons.edit,
              color: MyColors.white,
            ),
            color: Colors.grey,
          ),
        if(sharedPreferences.getString("u")=="1")
          SwipeAction(
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("login");
              addLogin(place.id??"");
              // states.remove(state);
              // list.removeAt(index);
              // setState(() {});
            },
            icon: Icon(
              Icons.manage_accounts,
              color: MyColors.white,
            ),
            color: Colors.blue.withOpacity(0.7),
          ),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PlaceDetails(id: place.id??"", name: place.name??'',)));
        },
        child: SizedBox(
          height: 210,
          child: Card(
            shadowColor: Colors.grey,
            elevation: 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: Image.network(
                      Environment.imageUrl+(place.image??""),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Text(
                        place.name??"",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("r")=="1") {
      getPlaces();
    }
    else {
      load = true;
      setState(() {

      });
    }

  }

  Future<void> getPlaces() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    PlaceListResponse placeListResponse = await APIService().getPlaces(queryParameters);
    print("placeListResponse.toJson()");
    print(placeListResponse.toJson());

    places = placeListResponse.places ?? [];
    load = true;

    setState(() {

    });
  }

  Future<void> searchPlaces() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.search,
      "place" : search.text
    };
    PlaceListResponse placeListResponse = await APIService().getPlaces(queryParameters);
    print("placeListResponse.toJson()");
    print(placeListResponse.toJson());

    places = placeListResponse.places ?? [];

    setState(() {

    });
  }

  Future<void> deletePlace(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deletePlace(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }

  void addPlace(String act, Places? place) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddPlace(
          act: act,
          place: place,
        );
      },
    ).then((value) {
      if(value=="Success")
        getPlaces();
    });
  }

  void addLogin(String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddPlaceLogin(
          id: id,
        );
      },
    );
  }
}
