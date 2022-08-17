import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/admin/AddUser.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/FamilyListResponse.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/toast/Toast.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({Key? key}) : super(key: key);

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  bool load = false;
  List<Families> families = [];
  List<Widget> info = [];
  List<TextEditingController> infoController = [];
  List<bool?> infoValidate = [];
  List<String?> infoError = [];

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool ignore = false;

  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Members"),
      ),
      bottomNavigationBar: IgnorePointer(
        ignoring: ignore || infoController.isEmpty,
        child: Container(
          height: 45,
          margin: EdgeInsets.symmetric(horizontal: MySize.size15(context), vertical: MySize.sizeh2(context)),
          child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate() && infoController.isNotEmpty) {
                  print("Validated");

                  ignore = true;
                  setState(() {

                  });
                  addFamily();
                } else {
                  print("Not Validated");
                }
              },
              child: Text("Add"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  infoController.isNotEmpty ? MyColors.colorPrimary : MyColors.grey10
              )
            ),
          ),
        ),
      ),
      body: load ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      addInfo();
                    },
                    icon: Icon(
                      Icons.add
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if(info.isNotEmpty) {
                        info.removeLast();
                        setState(() {

                        });
                      }

                    },
                    icon: Icon(
                      Icons.remove
                    ),
                  )
                ],
              ),
              ListView.separated(
                itemCount: families.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, index) {
                  return getFamilyCard(families[index]);
                },
              ),
              Form(
                key: formkey,
                child: ListView.separated(
                  itemCount: info.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, index) {
                    return info[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getFamilyCard(Families family) {
    return SwipeActionCell(
      key: ValueKey(family),
      trailingActions: <SwipeAction>[
        SwipeAction(
            onTap: (CompletionHandler handler) async {
              await handler(true);
              families.remove(family);
              deleteFamily(family.id??"");
            },
            icon: Icon(
              Icons.delete,
              color: MyColors.white,
            ),
            color: Colors.red
        ),
        // SwipeAction(
        //   onTap: (CompletionHandler handler) async {
        //     handler(false);
        //     print("edit");
        //     updateFamily(APIConstant.update, family);
        //     // states.remove(state);
        //     // list.removeAt(index);
        //     setState(() {});
        //   },
        //   icon: Icon(
        //     Icons.edit,
        //     color: MyColors.white,
        //   ),
        //   color: Colors.grey,
        // ),
      ],
      child: SizedBox(
        height: 50,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            child: getDetails("Name", family.name??"")
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
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

  // void updateFamily(String update, Families family) {
  //   Map<String,String> queryParameters = {
  //     APIConstant.act : APIConstant.update,
  //     "id" : family.id??"",
  //   };
  //   Response response = await APIService().deleteFamily(queryParameters);
  //   print(response.toJson());
  //
  //
  //   Toast.sendToast(context, response.status??"");
  //
  //   setState(() {
  //
  //   });
  // }

  Future<void> deleteFamily(String id) async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.delete,
      "id" : id
    };
    Response response = await APIService().deleteFamily(queryParameters);
    print(response.toJson());


    Toast.sendToast(context, response.status??"");

    setState(() {

    });
  }

  void addInfo() {
    infoController.add(TextEditingController());
    infoValidate.add(false);
    infoError.add("");
    info.add(
        TextFormField(
          controller: infoController.last,
          // cursorColor: MyColors.colorPrimary,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            errorText: infoValidate.last! ? infoError.last : null,
            label: Text("Name"),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            String message = "";
            if (value!.isEmpty) {
              return "* Required";
            } else {
              return null;
            }

          },
        )
    );
    setState(() {

    });
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

    });
    getFamilies();
  }

  Future<void> getFamilies() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "cus_id" : sharedPreferences.getString("id")??""
    };
    print(queryParameters);
    FamilyListResponse familyListResponse = await APIService().getFamilies(queryParameters);
    print(familyListResponse.toJson());

    families = familyListResponse.families ?? [];
    load = true;

    setState(() {

    });
  }

  Future<void> addFamily() async {
    Map<String,dynamic> queryParameters = {
      APIConstant.act : APIConstant.add,
      "cus_id" : sharedPreferences.getString("id")??"",
      "family" : getFamilyList().toString()
    };
    print(queryParameters);
    Response response = await APIService().addFamily(queryParameters);
    print(response.toJson());

    ignore = false;
    Toast.sendToast(context, response.status??"");

    if(response.msg=="Success" && response.status=="Family Added") {
      load = false;
      infoController = [];
      info = [];
      infoValidate = [];
      infoError = [];
      getFamilies();
    }
    setState(() {

    });
  }

  getFamilyList() {
    // List<Map<String, dynamic>> list = [];
    String list = infoController.map((info) {
      String map= "{";
      map+='"name":"${info.text}"}' ;
      return map;
    }).join(',,');
    return list;
  }

}
