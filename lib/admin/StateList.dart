import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:delight_card/admin/AddState.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/toast/Toast.dart';

import '../api/APIConstant.dart';

class StateList extends StatefulWidget {
  const StateList({Key? key}) : super(key: key);

  @override
  State<StateList> createState() => _StateListState();
}

class _StateListState extends State<StateList> {
  bool load = false;
  List<States> states = [];
  @override
  void initState() {
    getStates();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("States"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addState(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: states.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getStateCard(states[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getStateCard(States state) {
    return SwipeActionCell(
      key: ValueKey(state),
      trailingActions: <SwipeAction>[
        SwipeAction(
            onTap: (CompletionHandler handler) async {
              await handler(true);
              states.remove(state);
              deleteState(state.id??"");
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
            addState(APIConstant.update, state);
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
                  getTitle(state.name??""),
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

  Future<void> getStates() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    StateListResponse stateListResponse = await APIService().getStates(queryParameters);
    print(stateListResponse.toJson());

    states = stateListResponse.states ?? [];
    load = true;

    setState(() {

    });
  }

  void addState(String act, States? state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddState(
          act: act,
          state: state,
        );
      },
    ).then((value) {
      if(value=="Success")
        getStates();
    });
  }

  Future<void> deleteState(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteState(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }
}
