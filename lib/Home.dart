import 'package:delight_card/place/PlaceHome.dart';
import 'package:delight_card/place/VerifyCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Settings.dart';
import 'package:delight_card/admin/AdminHome.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/CustomerCard.dart';
import 'package:delight_card/customer/CustomerHome.dart';
import 'package:delight_card/customer/PlaceList.dart';
import 'package:delight_card/staff/Cards.dart';
import 'package:delight_card/staff/StaffHome.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool load = false;
  late SharedPreferences sharedPreferences;

  List<Widget> bodyWidget = [];
  int selectedIndex = 0;

  @override
  void initState() {
    start();
    super.initState();
  }
  
  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bodyWidget = [
      sharedPreferences.getString("login_type")=="customer" ?
      CustomerHome()
      : sharedPreferences.getString("login_type")=="place_login" ?
      PlaceHome()
      : sharedPreferences.getString("login_type")=="admin" ?
      AdminHome()
      : StaffHome(),
      if(sharedPreferences.getString("login_type")=="staff" && sharedPreferences.getString("role")=="1")
        Cards(id: sharedPreferences.getString("id")??""),
      if(sharedPreferences.getString("login_type")=="customer")
        CustomerCard(),
      if(sharedPreferences.getString("login_type")=="place_login")
        VerifyCard(),
      Settings()
    ];
    load = true;
    setState(() {

    });
  }


  Future<void> _onItemTapped(int index) async {
    selectedIndex = index;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            if(sharedPreferences.getString("login_type")=="staff" && sharedPreferences.getString("role")=="1")
              BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account_rounded),
                label: 'Customers',
              ),
            if(sharedPreferences.getString("login_type")=="customer" || sharedPreferences.getString("login_type")=="place_login")
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card_rounded),
                label: 'Card',
              ),
            // if(sharedPreferences.getString("login_type")=="place_login")
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.credit_card_rounded),
            //     label: 'Card',
            //   ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: MyColors.colorPrimary,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
        body: bodyWidget[selectedIndex]
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
