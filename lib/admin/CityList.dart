import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/admin/AddCity.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/CityListResponse.dart';
import 'package:delight_card/model/CityListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';

class CityList extends StatefulWidget {
  const CityList({Key? key}) : super(key: key);

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  bool load = false;
  List<Cities> cities = [];
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load ? Scaffold(
      appBar: AppBar(
        title: const Text("Cities"),
      ),
      floatingActionButton: sharedPreferences.getString("c")=="1" ? FloatingActionButton(
        onPressed: () {
          addCity(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ) : null,
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: cities.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getCityCard(cities[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    )
    : Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getCityCard(Cities city) {
    return SwipeActionCell(
      key: ValueKey(city),
      trailingActions: <SwipeAction>[
        if(sharedPreferences.getString("d")=="1")
          SwipeAction(
              onTap: (CompletionHandler handler) async {
                await handler(true);
                cities.remove(city);
                deleteCity(city.id??"");
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
              addCity(APIConstant.update, city);
              // states.remove(state);
              // list.removeAt(index);
              setState(() {});
            },
            icon: Icon(
              Icons.edit,
              color: MyColors.white,
            ),
            color: Colors.grey,
          ),
      ],
      child: SizedBox(
        height: 80,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle(city.name??""),
                  getDetails("State", city.sName??"")
                ],
              ),
          ),
        ),
      ),
    );
  }

  getTitle(String title) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  getDetails(String title, String info) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              title+": ",
              style: TextStyle(
                fontSize: 18,
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
      ),
    );
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("r")=="1") {
      getCities();
    }
    else {
      load = true;
      setState(() {

      });
    }

  }

  Future<void> getCities() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    CityListResponse cityListResponse = await APIService().getCities(queryParameters);
    print(cityListResponse.toJson());

    cities = cityListResponse.cities ?? [];
    load = true;

    setState(() {

    });
  }

  void addCity(String act, Cities? city) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddCity(
          act: act,
          city: city,
        );
      },
    ).then((value) {
      if(value=="Success")
        getCities();
    });
  }

  Future<void> deleteCity(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteCity(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }
}
