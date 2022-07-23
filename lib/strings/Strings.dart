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

}