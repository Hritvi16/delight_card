import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/PlaceListResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetails extends StatefulWidget {
  final String id;
  final String name;
  const PlaceDetails({Key? key, required this.id,required this.name}) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  bool load = false;
  Places place = Places();


  @override
  void initState() {
    getPlaceDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        automaticallyImplyLeading: true,
      ),
      body: load ? SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                  child: Row(
                    children: [
                      getActions(Icons.local_offer_outlined, "Offers", Colors.lightBlueAccent, offers),
                      getActions(Icons.location_on_outlined, "Location", Colors.red, location),
                      getActions(Icons.call_outlined, "Call", Colors.green, call)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                  child: Column(
                    children: [
                      if(place.placeType=="Restaurant")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if((place.isVeg??"")=="1" || (place.isVeg??"")=="2")
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                  "assets/icon/veg.png",
                                  height: 40,
                                ),
                              ),
                            if((place.isVeg??"")=="0" || (place.isVeg??"")=="2")
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.asset(
                                  "assets/icon/nonveg.png",
                                  height: 40,
                                ),
                              ),
                          ],
                        ),
                      if(place.placeType=="Restaurant")
                        SizedBox(
                          height: 30,
                        ),
                      getDetails("Morning Timing", (place.startTime??"")),
                      SizedBox(
                        height: 30,
                      ),
                      getDetails("Evening Timing", (place.endTime??"")),
                      SizedBox(
                        height: 30,
                      ),
                      getDetails("Address", (place.address??"")),
                      SizedBox(
                        height: 30,
                      ),
                      getDetails("Speciality", place.speciality??""),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    ) ;
  }

  getActions(IconData icon, String title, Color color, function) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }

  getDetails(String title, String info) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Text(
              title+" : ",
              style: TextStyle(
                  fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
          )
        ],
      );
  }

  offers() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offers",
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(top: 3, bottom: 6),
                    color: Colors.lightBlueAccent,
                  ),
                  Text(place.description??""),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "* Terms & Conditions",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyColors.red
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(top: 3, bottom: 6),
                    color: MyColors.red,
                  ),
                  Text(
                    place.tc??"",
                    style: TextStyle(
                      color: MyColors.red
                    ),
                  )
                ],
              )
            ),
          ),
        );
      },
    );
  }

  location() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(double.parse(place?.lat??"0"),double.parse(place?.longi??"0")),
      title: place.name??"",
    );
  }

  call() {
    launch("tel://"+(place.mobile??""));
  }

  Future<void> getPlaceDetails() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : widget.id
    };
    PlaceResponse placeResponse = await APIService().getPlaceDetails(queryParameters);
    print(placeResponse.toJson());

    place = placeResponse.places ?? Places();
    load = true;

    setState(() {

    });
  }

}
