import 'package:flutter/widgets.dart';
import 'package:delight_card/admin/AreaList.dart';
import 'package:delight_card/admin/CityList.dart';
import 'package:delight_card/admin/CustomerList.dart';
import 'package:delight_card/admin/RoleList.dart';
import 'package:delight_card/admin/StaffList.dart';
import 'package:delight_card/admin/StateList.dart';
import 'package:delight_card/admin/UsersList.dart';
import 'package:delight_card/admin/PlaceList.dart';

class Strings{
  static List<String> access= ["Users", "Staffs", "Customers", "States" , "Cities" , "Areas", "Places", "Roles"];
  static List<Widget> access_widget= [UsersList(), StaffList(), CustomerList(), StateList(), CityList(), AreaList(), PlaceList(), RoleList()];
  static List<String> access_icon= ["assets/icon/user.png", "assets/icon/staff.png", "assets/icon/customer.png", "assets/icon/state.png", "assets/icon/city.png", "assets/icon/area.png", "assets/icon/place.png", "assets/icon/role.png"];
  // static List<String> admin_= ["Users", "Staffs", "Customers", "States" , "Cities" , "Areas", "Places", "Roles"];
  static String tc = "1) Turiean card offers cannot be combined with any other mobile app offers/booklet coupon/other ongoing offer from food outlet.\n\n"
      "2) If you lost your card you have to pay 100rs to get new one, meanwhile you can avail the offer from mobile app.\n\n"
      "3) Taxes and other charges will be levied as applicable.\n\n"
      "4) Do confirm with restaurant about usage of any offer in prior before placing any order.\n\n"
      "5) Some offer may not be available on special holidays. Do confirm with restaurant in prior.\n\n"
      "6) Offer can be redeemed only on availability of the products.\n\n"
      "7) Turiean card reserved right of admission.\n\n"
      "8) Offers will be changed frequently without any prior notice.\n\n"
      "9) All turiean card offers are controlled by restaurant.";
}