import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/UserAccessListResponse.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/strings/Strings.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({Key? key}) : super(key: key);

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  late SharedPreferences sharedPreferences;
  List<UserAccess> userAccesses = [];
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
                  itemCount: userAccesses.length,
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
                    return getAccessCard(userAccesses[index]);
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


  Widget getAccessCard(UserAccess userAccess) {
    return GestureDetector(
      onTap: () async {
        print(userAccess.access??"");
        print(Strings.access.indexOf(userAccess.access??""));
        sharedPreferences.setString("c", userAccess.c??"0");
        sharedPreferences.setString("u", userAccess.u??"0");
        sharedPreferences.setString("r", userAccess.r??"0");
        sharedPreferences.setString("d", userAccess.d??"0");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Strings.access_widget[Strings.access.indexOf(userAccess.access??"")]));
      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              Environment.iconUrl + (userAccess.icon??""),
              height: 50,
            ),
            Text(
              userAccess.access??"",
              style: TextStyle(
                  fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getUserAccess();
  }

  getUserAccess() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getBySID,
      "id" : sharedPreferences.getString("id")??""
    };
    UserAccessListResponse userAccessListResponse = await APIService().getUserAccess(queryParameters);
    print(userAccessListResponse.toJson());

    // userAccesses = userAccessListResponse.userAccess ?? [];
    userAccessListResponse.userAccess!.forEach((element) {
      if(element.c=="1")
        userAccesses.add(element);
    });
    load = true;
    setState(() {

    });
  }

}
