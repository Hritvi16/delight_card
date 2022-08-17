import 'package:delight_card/staff/Cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:delight_card/admin/AddStaff.dart';
import 'package:delight_card/admin/ManageRoles.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StaffListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key? key}) : super(key: key);

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  bool load = false;
  List<Staff> staffs = [];
  @override
  void initState() {
    getStaffs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staffs"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addStaff(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: staffs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getStaffCard(staffs[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getStaffCard(Staff staff) {
    return SwipeActionCell(
      key: ValueKey(staff),
      trailingActions: <SwipeAction>[
        SwipeAction(
            onTap: (CompletionHandler handler) async {
              await handler(true);
              staffs.remove(staff);
              deleteStaff(staff.id??"", staff.role??"");
            },
            icon: Icon(
              Icons.delete,
              color: MyColors.white,
            ),
            color: Colors.red
        ),
        SwipeAction(
          onTap: (CompletionHandler handler) async {
            handler(false);
            print("edit");
            addStaff(APIConstant.update, staff);
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
        SwipeAction(
          onTap: (CompletionHandler handler) async {
            handler(false);
            manageRoles(staff);
            print("setting");
            // addStaff(APIConstant.update, staff);
            // states.remove(state);
            // list.removeAt(index);
            setState(() {});
          },
          icon: Icon(
            Icons.settings,
            color: MyColors.white,
          ),
          color: MyColors.colorPrimary.withOpacity(0.3),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          print(staff.role);
          if(staff.role=="Agent") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cards(id: staff.id??"")));
          }
        },
        child: SizedBox(
          height: 100,
          child: Card(
            shadowColor: Colors.grey,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getDetails("Name", staff.name??""),
                    getDetails("Mobile No.", staff.phone??""),
                    getDetails("Role", staff.role??""),
                  ],
                ),
            ),
          ),
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

  Future<void> getStaffs() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    StaffListResponse staffListResponse = await APIService().getStaffs(queryParameters);
    print(staffListResponse.toJson());

    staffs = staffListResponse.staff ?? [];
    load = true;

    setState(() {

    });
  }

  void addStaff(String act, Staff? staff) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddStaff(
          act: act,
          staff: staff
        );
      },
    ).then((value) {
      if(value=="Success")
        getStaffs();
    });
  }

  Future<void> deleteStaff(String id, String role) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id,
      "role" : role
    };
    print(queryParameters);
    Response response = await APIService().deleteStaff(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }

  void manageRoles(Staff staff) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ManageRoles(
            staff: staff
        );
      },
    ).then((value) {
      if(value=="Success")
        getStaffs();
    });
  }
}
