import 'package:delight_card/model/CardVerificationResponse.dart';
import 'package:delight_card/model/FamilyListResponse.dart';
import 'package:delight_card/size/MySize.dart';
import 'package:delight_card/toast/Toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/colors/MyColors.dart';
import '../api/APIService.dart';
import '../model/CardListResponse.dart';

class VerifyCard extends StatefulWidget {
  const VerifyCard({Key? key}) : super(key: key);

  @override
  State<VerifyCard> createState() => _VerifyVerifyCardtate();
}

class _VerifyVerifyCardtate extends State<VerifyCard> {

  TextEditingController card = TextEditingController();

  Customers customer = Customers();
  List<Families> families = [];

  bool verify = false;
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) {
                    verifyCard();
                  },
                  controller: card,
                  // cursorColor: MyColors.colorPrimary,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    label: Text("Search Card No."),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        verifyCard();
                      },
                      child: Icon(
                        Icons.arrow_forward
                      ),
                    )
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
                ),
                SizedBox(
                  height: MySize.sizeh1(context),
                ),
                if(verify)
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            getVerifyCardDesign(),
                            SizedBox(
                              height: 10,
                            ),
                            getFamilyList()
                          ],
                        ),
                      )
                  ),
              ],
            ),
          )
      );
  }

  Widget getFamilyList() {
    return ListView.separated(
      itemCount: families.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (BuildContext context, index) {
        return getFamilyCard(families[index]);
      },
    );
  }

  Widget getFamilyCard(Families family) {
    return Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            alignment: Alignment.center,
            child: getDetails("Name", family.name??"")
        ),
    );
  }

  Widget getVerifyCardDesign() {
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
                // getDetails("Secret Code", customer.secret??""),
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
  }

  verifyCard() async {
    Map<String,String> data = {
      APIConstant.act : APIConstant.verify,
      "card" : card.text
    };

    CardVerificationResponse cardVerificationResponse = await APIService().verifyCard(data);
    print(cardVerificationResponse.toJson());

    if(cardVerificationResponse.msg=="Card Retrieved") {
      verify = true;
    }
    customer = cardVerificationResponse.customer ?? Customers();
    families = cardVerificationResponse.family ?? [];

    Toast.sendToast(context, cardVerificationResponse.msg??"");

    setState(() {

    });
  }
}
