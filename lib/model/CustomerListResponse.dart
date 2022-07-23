/// customers : [{"city":"Surat","id":"1","name":"Jack","address":"Dindoli","pincode":"394210","phone":"7228988032"},{"city":"Surat","id":"2","name":"Kundan Yadav","address":"Dindoli","pincode":"394210","phone":"7878928817"},{"city":"Surat","id":"3","name":"Kundan","address":"Dindoli","pincode":"394210","phone":"7878928818"},{"city":"Surat","id":"4","name":"hritvi","address":"rampura","pincode":"395003","phone":"9586033791"},{"city":"Surat","id":"5","name":"hritvi","address":"rampura","pincode":"395003","phone":"9586033792"},{"city":"Surat","id":"6","name":"hritvi","address":"rampura","pincode":"395003","phone":"9586033793"},{"city":"Surat","id":"7","name":"hritvi","address":"rampura","pincode":"395003","phone":"9586033794"}]

class CustomerListResponse {
  CustomerListResponse({
      List<Customers>? customers,}){
    _customers = customers;
}

  CustomerListResponse.fromJson(dynamic json) {
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

/// city : "Surat"
/// id : "1"
/// name : "Jack"
/// address : "Dindoli"
/// pincode : "394210"
/// phone : "7228988032"

class Customers {
  Customers({
      String? city, 
      String? id, 
      String? name, 
      String? address, 
      String? pincode, 
      String? phone,}){
    _city = city;
    _id = id;
    _name = name;
    _address = address;
    _pincode = pincode;
    _phone = phone;
}

  Customers.fromJson(dynamic json) {
    _city = json['city'];
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _pincode = json['pincode'];
    _phone = json['phone'];
  }
  String? _city;
  String? _id;
  String? _name;
  String? _address;
  String? _pincode;
  String? _phone;

  String? get city => _city;
  String? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get pincode => _pincode;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['pincode'] = _pincode;
    map['phone'] = _phone;
    return map;
  }

}