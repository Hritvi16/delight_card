import 'package:delight_card/customer/AreaList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Home.dart';
import 'package:delight_card/customer/PlaceList.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/model/CityListResponse.dart';

class CityList extends StatefulWidget {
  const CityList({Key? key}) : super(key: key);

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  bool load = false;
  List<Cities> cities = [];
  @override
  void initState() {
    getCities();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities"),
      ),
      body: load ? Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: cities.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 120
          ),
          itemBuilder: (BuildContext context, index) {
            return getCityCard(cities[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getCityCard(Cities city) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("c_id", city.id??"-1");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => AreaList(c_id : city.id??"-1")));
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
          Text(city.name??"", textAlign: TextAlign.center,)
        ],
      ),
    );
  }

  Future<void> getCities() async {
    Map<String,String> queryParameters = {APIConstant.act : APIConstant.getAll};
    CityListResponse cityListResponse = await APIService().getCities(queryParameters);
    print(cityListResponse.toJson());

    cities = cityListResponse.cities ?? [];
    load = true;

    setState(() {

    });
  }
}
