import 'package:delight_card/customer/CityList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/AreaList.dart';
import 'package:delight_card/size/MySize.dart';
import '../model/PlacesTypeListResponse.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  late SharedPreferences sharedPreferences;
  List<PlacesType> placesTypes = [];
  bool load = false;

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
            padding: EdgeInsets.symmetric(
              horizontal: MySize.size3(context),
              vertical: MySize.sizeh1(context)
            ),
            child: Column(
              children: [
                Container(
                  width: MySize.size100(context),
                  color: MyColors.white,
                  child: Image.asset(
                    "assets/logo/company_logo.JPG",
                    height: MySize.sizeh25(context),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: placesTypes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 130
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return getPlacesTypeCard(placesTypes[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  Widget getPlacesTypeCard(PlacesType placesType) {
    return GestureDetector(
      onTap: () async {
        if((placesType?.name??"")!="Terms & Condition" && (placesType?.name??"")!="Customer Care" && (placesType?.name??"")!="staff") {
          sharedPreferences.setString("pt_id", placesType.id??"");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CityList()));
        }

      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              Environment.iconUrl + (placesType.icon??""),
              height: 50,
            ),
            Text(
              placesType.name??"",
              style: TextStyle(
                  fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getPlacesType();
  }

  getPlacesType() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    PlacesTypeListResponse placesTypeListResponse = await APIService().getPlacesType(queryParameters);
    print(placesTypeListResponse.toJson());

    placesTypes = placesTypeListResponse.placesType ?? [];
    load = true;
    setState(() {

    });
  }

}
