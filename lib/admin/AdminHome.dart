import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/strings/Strings.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  late SharedPreferences sharedPreferences;
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
                  itemCount: Strings.access.length,
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
                    return getAccessCard(index);
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


  Widget getAccessCard(int ind) {
    return GestureDetector(
      onTap: () async {
        sharedPreferences.setString("c", "1");
        sharedPreferences.setString("u", "1");
        sharedPreferences.setString("r", "1");
        sharedPreferences.setString("d", "1");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Strings.access_widget[ind]));
      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              Strings.access_icon[ind],
              height: 50,
            ),
            Text(
              Strings.access[ind],
              style: TextStyle(
                fontSize: 18,
                color: MyColors.colorPrimary
              ),
              textAlign: TextAlign.center,
            )
          ],
        )
      ),
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    load = true;

    setState(() {

    });
  }
}
