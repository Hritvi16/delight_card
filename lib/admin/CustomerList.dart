import 'package:flutter/material.dart';
import 'package:delight_card/api/APIConstant.dart';
import 'package:delight_card/api/APIService.dart';
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/model/CustomerListResponse.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool load = false;
  List<Customers> customers = [];
  List<Customers> active = [];
  List<Customers> inactive = [];
  List<Customers> na = [];
  TextEditingController name = new TextEditingController();
  @override
  void initState() {
    getCustomers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
          dividerColor: Colors.transparent,
          textTheme: GoogleFonts.latoTextTheme()
      ),
      home: load ? DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  // title: Text("Customers"),

                  title: TextFormField(
                    onFieldSubmitted: (value) {
                      customers = [];
                      active = [];
                      inactive = [];
                      na = [];
                      setState(() {

                      });
                      if(value.isNotEmpty)
                        getSearchCustomers();
                      else
                        getCustomers();
                    },
                    controller: name,
                    style: TextStyle(color: MyColors.black),
                    decoration: InputDecoration(
                      hintText: "Search Customer",
                    ),
                    cursorColor: MyColors.black,
                    keyboardType: TextInputType.name,
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    TabBar(
                      padding: EdgeInsets.all(10),
                      labelColor: MyColors.colorPrimary,
                      indicatorColor: MyColors.colorPrimary,
                      unselectedLabelColor: MyColors.black,
                      labelStyle: TextStyle(
                        fontSize: 12
                      ),
                      tabs: [
                        Tab(
                          text:"ACTIVE",
                        ),
                        Tab(
                          text: "INACTIVE",
                        ),
                        Tab(
                          text: "NOT APPLIED",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          getCustomerList("ACTIVE"),
                          getCustomerList("INACTIVE"),
                          getCustomerList("NOT APPLIED")
                        ],
                      ),
                    ),
                  ],
                )
            ),
          )
      ) : const Center(
          child: CircularProgressIndicator(),
        ),
    );
  }

  getCustomerList(String type) {
    return ListView.separated(
      itemCount: type=="ACTIVE" ? active.length : type=="INACTIVE" ? inactive.length : na.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (BuildContext context, index) {
        return getCustomerCard(type=="ACTIVE" ? active[index] : type=="INACTIVE" ? inactive[index] : na[index]);
      },
    );
  }

  Widget getCustomerCard(Customers customer) {
    print(customer.address?.length);
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //     UserDetails(id: User.id??"")));
      },
      child: SizedBox(
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
                  SizedBox(
                    height: 5,
                  ),
                  getDetails("Mobile No.", customer.phone??""),
                  SizedBox(
                    height: 5,
                  ),
                  getDetails("City", customer.city??""),
                  SizedBox(
                    height: 5,
                  ),
                  getDetails("Family Members", customer.family??"0"),
                  SizedBox(
                    height: 5,
                  ),
                  getDetails("Address", customer.address??""),
                ],
              ),
          ),
        ),
      ),
    );
  }

  getDetails(String title, String info) {
    return Row(
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
    );
  }

  Future<void> getCustomers() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getAll,
    };
    CustomerListResponse customerListResponse = await APIService().getCustomers(queryParameters);
    print(customerListResponse.toJson());

    customers = customerListResponse.customers ?? [];
    customers.forEach((element) {
      if(element.status=="ACTIVE") {
        active.add(element);
      }
      else if(element.status=="INACTIVE") {
        inactive.add(element);
      }
      else {
        na.add(element);
      }
    });
    load = true;

    setState(() {

    });
  }

  Future<void> getSearchCustomers() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getBySearch,
      "search" : name.text
    };
    CustomerListResponse customerListResponse = await APIService().getCustomers(queryParameters);
    print(customerListResponse.toJson());

    customers = customerListResponse.customers ?? [];
    customers.forEach((element) {
      if(element.status=="ACTIVE") {
        active.add(element);
      }
      else if(element.status=="INACTIVE") {
        inactive.add(element);
      }
      else {
        na.add(element);
      }
    });
    load = true;

    setState(() {

    });
  }
}
