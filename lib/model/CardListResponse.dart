/// customers : [{"id":"1","name":"Kundan Yadav","issue_date":"2022-06-26","expiry_date":"2022-07-30","staff":"Kundan Yadav Maryad","secret":"45677","status":"ACTIVE"},{"id":"2","name":"Kundan Yadav","issue_date":"2022-06-26","expiry_date":"2022-07-26","staff":"Kundan Yadav Maryad","secret":"889977","status":"INACTIVE"}]

class CardListResponse {
  CardListResponse({
      List<Customers>? customers,}){
    _customers = customers;
}

  CardListResponse.fromJson(dynamic json) {
    if (json['customers'] != null) {
      _customers = [];
      json['customers'].forEach((v) {
        _customers?.add(Customers.fromJson(v));
      });
    }
  }
  List<Customers>? _customers;

  List<Customers>? get customers => _customers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customers != null) {
      map['customers'] = _customers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CardResponse {
  CardResponse({
      Customers? card,}){
    _card = card;
}

  CardResponse.fromJson(dynamic json) {
    _card = json['card']!=null ? Customers.fromJson(json['card']) : null;
  }
  Customers? _card;

  Customers? get card => _card;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    return map;
  }

}

class ApplyCardResponse {
  ApplyCardResponse({
      Customers? card,
      String? msg,
      String? status,}){
    _card = card;
    _msg = msg;
    _status = status;
}

  ApplyCardResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _card = json['card']!=null ? Customers.fromJson(json['card']) : null;
  }
  String? _msg;
  String? _status;
  Customers? _card;

  Customers? get card => _card;
  String? get msg => _msg;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// name : "Kundan Yadav"
/// issue_date : "2022-06-26"
/// expiry_date : "2022-07-30"
/// staff : "Kundan Yadav Maryad"
/// secret : "45677"
/// status : "ACTIVE"

class Customers {
  Customers({
      String? id, 
      String? name, 
      String? cardNo,
      String? issueDate,
      String? expiryDate,
      String? staff, 
      String? agent,
      String? secret,
      String? status,
      String? family,}){
    _id = id;
    _name = name;
    _cardNo = cardNo;
    _issueDate = issueDate;
    _expiryDate = expiryDate;
    _staff = staff;
    _agent = agent;
    _secret = secret;
    _status = status;
    _family = family;
}

  Customers.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _cardNo = json['card_no'];
    _issueDate = json['issue_date'];
    _expiryDate = json['expiry_date'];
    _staff = json['staff'];
    _agent = json['agent'];
    _secret = json['secret'];
    _status = json['status'];
    _family = json['family'];
  }
  String? _id;
  String? _name;
  String? _cardNo;
  String? _issueDate;
  String? _expiryDate;
  String? _staff;
  String? _agent;
  String? _secret;
  String? _status;
  String? _family;

  String? get id => _id;
  String? get name => _name;
  String? get cardNo => _cardNo;
  String? get issueDate => _issueDate;
  String? get expiryDate => _expiryDate;
  String? get staff => _staff;
  String? get agent => _agent;
  String? get secret => _secret;
  String? get status => _status;
  String? get family => _family;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['card_no'] = _cardNo;
    map['issue_date'] = _issueDate;
    map['expiry_date'] = _expiryDate;
    map['staff'] = _staff;
    map['agent'] = _agent;
    map['secret'] = _secret;
    map['status'] = _status;
    map['family'] = _family;
    return map;
  }

}