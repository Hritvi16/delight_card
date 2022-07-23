import 'package:delight_card/size/MySize.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/customer/AreaList.dart';
import 'package:delight_card/customer/PlaceDetails.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/PlaceListResponse.dart';

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
    getPlaces();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  AreaList(c_id: sharedPreferences.getString("c_id")??"-1",)));
            },
            child: Text(
              "Change Area",
              style: TextStyle(
                color: MyColors.white
              ),
            ),
          )
        ],
      ),
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
    );
  }

  Widget getPlaceCard(Places place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            PlaceDetails(id: place.id??"",name: place.name??"")));
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
    );
  }

  Future<void> getPlaces() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByPAID,
      "ar_id" : sharedPreferences.getString("ar_id")??"-1",
      "pt_id" : sharedPreferences.getString("pt_id")??"-1",
    };
    PlaceListResponse placeListResponse = await APIService().getPlaces(queryParameters);
    print(placeListResponse.toJson());

    places = placeListResponse.places ?? [];
    load = true;

    setState(() {

    });
  }

  Future<void> searchPlaces() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.search,
      "ar_id" : sharedPreferences.getString("ar_id")??"-1",
      "pt_id" : sharedPreferences.getString("pt_id")??"-1",
      "place" : search.text
    };
    PlaceListResponse placeListResponse = await APIService().getPlaces(queryParameters);
    print("placeListResponse.toJson()");
    print(placeListResponse.toJson());

    places = placeListResponse.places ?? [];

    setState(() {

    });
  }
}
