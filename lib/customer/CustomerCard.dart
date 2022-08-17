import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/Home.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/AddCard.dart';
import 'package:delight_card/customer/FamilyList.dart';
import 'package:delight_card/model/CardListResponse.dart';
import 'package:delight_card/size/MySize.dart';

class CustomerCard extends StatefulWidget {
  const CustomerCard({Key? key}) : super(key: key);

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {

  Customers? card;
  bool load = false;
  late SharedPreferences sharedPreferences;
  
  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? (card!=null && card?.issueDate!=null) ? Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FamilyList()));
          },
          child: Icon(
              Icons.family_restroom
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MySize.sizeh2(context), horizontal: MySize.size3(context)),
            child: Column(
              children: [
                getTicketCard()
              ],
            ),
          ),
        ),
      )
      : Container()
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  getTicketCard() {
    print(card?.toJson());
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          border: Border.all(color: MyColors.grey1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Container(
            width: MySize.size100(context) - MySize.size8(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      color: MyColors.white,
                      // height: 200,
                      child: Image.asset(
                        "assets/logo/company_logo.JPG",
                        fit: BoxFit.fitWidth,
                      )
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: MyColors.grey1))
                    ),
                    child: Column(
                      children: [
                        getDetails("Card No.", card?.cardNo??""),
                        SizedBox(
                          height: 10,
                        ),
                        getDetails("Name", card?.name??""),
                        SizedBox(
                          height: 10,
                        ),
                        getDetails("Issue Date", card?.issueDate??""),
                        SizedBox(
                          height: 10,
                        ),
                        getDetails("Expiry Date", card?.expiryDate??""),
                        SizedBox(
                          height: 10,
                        ),
                        getDetails("Members", card?.family??"0"),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // getDetails("Address", card?.address??""),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: card?.issueDate!=null ? MyColors.green500 : MyColors.red,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
              ),
            ),
          )
        ],
      ),
    );
  }

  getDetails(String title, String info) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              title+": ",
              style: TextStyle(
                fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          )
        ],
    );
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await getCard();
    if(card==null || card?.issueDate==null) {
      addCard(card==null ? APIConstant.add : APIConstant.update, card);
    }
    load = true;
  }

  getCard() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByCID,
      "id" : sharedPreferences.getString("id")??""
    };

    CardResponse cardResponse = await APIService().getCard(queryParameters);
    print(cardResponse.toJson());

    card = cardResponse.card??null;
    // card.forEach((element) {
      // if(element.status=="ACTIVE") {
      //   active.add(element);
      // }
      // else {
      //   inactive.add(element);
      // }
    // });


    setState(() {

    });
  }

  void addCard(String act, Customers? card) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddCard(
          act: act,
          card: card,
        );
      },
    ).then((value) {
      if(value=="Success")
        getCard();
      else
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Home()),
                (Route<dynamic> route) => false);
    });
  }
}
