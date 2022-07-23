import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:delight_card/admin/AddRole.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

class RoleList extends StatefulWidget {
  const RoleList({Key? key}) : super(key: key);

  @override
  State<RoleList> createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  bool load = false;
  List<Roles> roles = [];
  @override
  void initState() {
    getRoles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roles"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          auRole(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: roles.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getRoleCard(roles[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getRoleCard(Roles role) {
    return SwipeActionCell(
      key: ValueKey(role),
      trailingActions: <SwipeAction>[
        SwipeAction(
            onTap: (CompletionHandler handler) async {
              await handler(true);
              roles.remove(role);
              deleteRole(role.id??"");
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
            auRole(APIConstant.update, role);
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
        height: 50,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle(role.name??""),
                ],
              ),
          ),
        ),
      ),
    );
  }

  getTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500
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

  Future<void> getRoles() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    RoleListResponse roleListResponse = await APIService().getRoles(queryParameters);
    print(roleListResponse.toJson());

    roles = roleListResponse.roles ?? [];
    load = true;

    setState(() {

    });
  }

  void auRole(String act, Roles? role) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddRole(
          act: act,
          role: role,
        );
      },
    ).then((value) {
      if(value=="Success")
        getRoles();
    });
  }
  
  Future<void> deleteRole(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteRole(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }
}
