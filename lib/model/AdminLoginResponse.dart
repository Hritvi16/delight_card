/// msg : "Logged In"
/// status : "Success"
/// data : {"id":"1","name":"Hritvi","email":"hritvi@gmail.com","password":"81dc9bdb52d04dc20036dbd8313ed055","role":"1"}

class AdminLoginResponse {
  AdminLoginResponse({
      String? msg, 
      String? status, 
      Data? data,}){
    _msg = msg;
    _status = status;
    _data = data;
}

  AdminLoginResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _msg;
  String? _status;
  Data? _data;

  String? get msg => _msg;
  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// name : "Hritvi"
/// email : "hritvi@gmail.com"
/// password : "81dc9bdb52d04dc20036dbd8313ed055"
/// role : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? email, 
      String? password, 
      String? role,}){
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _role = role;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _role = json['role'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _role;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['role'] = _role;
    return map;
  }

}