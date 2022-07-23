import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/CityList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Home.dart';
import 'package:delight_card/customer/PlaceList.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/AreaListResponse.dart';

class AreaList extends StatefulWidget {
  final String c_id;
  const AreaList({Key? key, required this.c_id}) : super(key: key);

  @override
  State<AreaList> createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  bool load = false;
  List<Areas> areas = [];
  @override
  void initState() {
    getAreas();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Areas"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                  CityList()));
            },
            child: Text(
              "Change City",
              style: TextStyle(
                  color: MyColors.white
              ),
            ),
          )
        ],
      ),
      body: load ? Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: areas.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 120
          ),
          itemBuilder: (BuildContext context, index) {
            return getAreaCard(areas[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getAreaCard(Areas area) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("ar_id", area.id??"-1");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => PlaceList()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.5),
            radius: 40,
            child: const Icon(
                Icons.location_on_outlined
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(area.name??"", textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Future<void> getAreas() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "c_id" : widget.c_id
    };
    AreaListResponse areaListResponse = await APIService().getAreas(queryParameters);
    print(areaListResponse.toJson());

    areas = areaListResponse.areas ?? [];
    load = true;

    setState(() {

    });
  }
}
