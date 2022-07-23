import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/admin/AddArea.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/AreaListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/toast/Toast.dart';

class AreaList extends StatefulWidget {
  const AreaList({Key? key}) : super(key: key);

  @override
  State<AreaList> createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  bool load = false;
  List<Areas> areas = [];
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load ? Scaffold(
      appBar: AppBar(
        title: const Text("Areas"),
      ),
      floatingActionButton: sharedPreferences.getString("c")=="1" ? FloatingActionButton(
        onPressed: () {
          addArea(APIConstant.add, null);
        },
        child: Icon(
          Icons.add
        ),
      ) : null,
      body: load ? Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: areas.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, index) {
            return getAreaCard(areas[index]);
          },
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    )
    : Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getAreaCard(Areas area) {
    return SwipeActionCell(
      key: ValueKey(area),
      trailingActions: <SwipeAction>[
        if(sharedPreferences.getString("d")=="1")
          SwipeAction(
              onTap: (CompletionHandler handler) async {
                await handler(true);
                areas.remove(area);
                deleteArea(area.id??"");
              },
              icon: Icon(
                Icons.delete,
                color: MyColors.white,
              ),
              color: Colors.red
          ),
        if(sharedPreferences.getString("u")=="1")
          SwipeAction(
            onTap: (CompletionHandler handler) async {
              handler(false);
              print("edit");
              addArea(APIConstant.update, area);
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle(area.name??""),
                  getDetails("City", area.cName??""),
                  getDetails("State", area.sName??"")
                ],
              ),
          ),
        ),
      ),
    );
  }

  getTitle(String title) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
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

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("r")=="1") {
      getAreas();
    }
    else {
      load = true;
      setState(() {

      });
    }

  }

  Future<void> getAreas() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    AreaListResponse areaListResponse = await APIService().getAreas(queryParameters);
    print(areaListResponse.toJson());

    areas = areaListResponse.areas ?? [];
    load = true;

    setState(() {

    });
  }

  void addArea(String act, Areas? area) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddArea(
          act: act,
          area: area,
        );
      },
    ).then((value) {
      if(value=="Success")
        getAreas();
    });
  }

  Future<void> deleteArea(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteArea(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }
}
