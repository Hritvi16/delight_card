/// msg : "Logged In"
/// status : "Success"
/// data : {"id":"4","name":"hritvi","phone":"9586033791","password":"81dc9bdb52d04dc20036dbd8313ed055","cityid":"1","address":"rampura","pincode":"395003"}

class LoginResponse {
  LoginResponse({
      String? msg, 
      String? status, 
      CustomerData? data,}){
    _msg = msg;
    _status = status;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _data = json['data'] != null ? CustomerData.fromJson(json['data']) : null;
  }
  String? _msg;
  String? _status;
  CustomerData? _data;

  String? get msg => _msg;
  String? get status => _status;
  CustomerData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : "4"
/// name : "hritvi"
/// phone : "9586033791"
/// password : "81dc9bdb52d04dc20036dbd8313ed055"
/// cityid : "1"
/// address : "rampura"
/// pincode : "395003"

class CustomerData {
  CustomerData({
      String? id, 
      String? name, 
      String? phone, 
      String? password, 
      String? cityid, 
      String? address, 
      String? pincode,}){
    _id = id;
    _name = name;
    _phone = phone;
    _password = password;
    _cityid = cityid;
    _address = address;
    _pincode = pincode;
}

  CustomerData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _password = json['password'];
    _cityid = json['cityid'];
    _address = json['address'];
    _pincode = json['pincode'];
  }
  String? _id;
  String? _name;
  String? _phone;
  String? _password;
  String? _cityid;
  String? _address;
  String? _pincode;

  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;
  String? get password => _password;
  String? get cityid => _cityid;
  String? get address => _address;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['password'] = _password;
    map['cityid'] = _cityid;
    map['address'] = _address;
    map['pincode'] = _pincode;
    return map;
  }

}