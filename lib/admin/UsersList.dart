import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:delight_card/admin/AddUser.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/UsersListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool load = false;
  List<Users> users = [];
  @override
  void initState() {
    getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: users.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getUserCard(users[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getUserCard(Users user) {
    return SwipeActionCell(
      key: ValueKey(user),
      trailingActions: <SwipeAction>[
        SwipeAction(
            onTap: (CompletionHandler handler) async {
              await handler(true);
              users.remove(user);
              deleteUser(user.id??"");
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
            addUser(APIConstant.update, user);
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
                  getDetails("Name", user.name??""),
                  getDetails("Email", user.email??""),
                ],
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

  Future<void> getUsers() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    UsersListResponse usersListResponse = await APIService().getUsers(queryParameters);
    print(usersListResponse.toJson());

    users = usersListResponse.users ?? [];
    load = true;

    setState(() {

    });
  }

  void addUser(String act, Users? user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddUser(
          act: act,
          user: user
        );
      },
    ).then((value) {
      if(value=="Success")
        getUsers();
    });
  }

  Future<void> deleteUser(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteUser(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }
}
