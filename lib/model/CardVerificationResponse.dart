import 'package:delight_card/model/CardListResponse.dart';
import 'package:delight_card/model/FamilyListResponse.dart';

/// msg : "Success"
/// status : "customer Retrieved"
/// customer : {"name":"hritvi","id":"1","cus_id":"4","customer_no":"TC62C81D9D71387","issue_date":"2022-07-08","expiry_date":"2023-07-08","staff_id":"1","secret":"968629","status":"ACTIVE"}
/// family : [{"name":"Henu"},{"name":"Priti"},{"name":"Pu"}]

class CardVerificationResponse {
  CardVerificationResponse({
    String? msg,
    String? status,
    Customers? customer,
    List<Families>? family,}){
    _msg = msg;
    _status = status;
    _customer = customer;
    _family = family;
  }

  CardVerificationResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _customer = json['customer'] != null ? Customers.fromJson(json['customer']) : null;
    if (json['family'] != null) {
      _family = [];
      json['family'].forEach((v) {
        _family?.add(Families.fromJson(v));
      });
    }
  }
  String? _msg;
  String? _status;
  Customers? _customer;
  List<Families>? _family;

  String? get msg => _msg;
  String? get status => _status;
  Customers? get customer => _customer;
  List<Families>? get family => _family;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    if (_family != null) {
      map['family'] = _family?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
