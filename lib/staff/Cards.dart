import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/CardListResponse.dart';

import '../api/APIService.dart';

class Cards extends StatefulWidget {
  final String id;
  const Cards({Key? key, required this.id}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {

  List<Customers> customers = [];
  List<Customers> active = [];
  List<Customers> inactive = [];

  bool load = false;
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
          dividerColor: Colors.transparent
      ),
      home: load ? DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                TabBar(
                  padding: EdgeInsets.all(10),
                  labelColor: MyColors.colorPrimary,
                  indicatorColor: MyColors.colorPrimary,
                  unselectedLabelColor: MyColors.black,
                  // labelStyle: TextStyle(
                  //   fontSize: MySize.font1(context)
                  // ),
                  tabs: [
                    Tab(
                      text:"ACTIVE",
                    ),
                    Tab(
                      text: "INACTIVE",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      getCardsList("ACTIVE"),
                      getCardsList("INACTIVE")
                    ],
                  ),
                ),
              ],
            )
          ),
        )
      )
          : Center(
        child: CircularProgressIndicator(
          color: MyColors.colorPrimary,
        ),
      ),
    );
  }

  Widget getCardsList(String type) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.separated(
        itemCount: type=="ACTIVE" ? active.length : inactive.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext context, index) {
          return getCardsDesign(type=="ACTIVE" ? active[index] : inactive[index]);
        },
      ),
    );
  }

  Widget getCardsDesign(Customers customer) {
    return SizedBox(
        height: 130,
        child: Card(
          shadowColor: Colors.grey,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getDetails("Name", customer.name??""),
                getDetails("Issued Date", customer.issueDate??""),
                getDetails("Expiry Date", customer.expiryDate??""),
                getDetails("Secret Code", customer.secret??""),
              ],
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
            flex: 3,
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

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

    });

    getCards();
  }

  getCards() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getBySID,
      "id" : widget.id
    };

    CardListResponse cardListResponse = await APIService().getCards(queryParameters);
    print(cardListResponse.toJson());

    customers = cardListResponse.customers ?? [];
    customers.forEach((element) {
      if(element.status=="ACTIVE") {
        active.add(element);
      }
      else {
        inactive.add(element);
      }
    });

    load = true;

    setState(() {

    });
  }
}
