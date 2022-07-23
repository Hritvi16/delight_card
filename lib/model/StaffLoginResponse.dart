/// msg : "Logged In"
/// status : "Success"
/// data : {"id":"2","name":"Hritvi","phone":"9586033791","password":"81dc9bdb52d04dc20036dbd8313ed055","code":"TN62C2CE1EC110A","roleid":"2","is_delete":"0"}

class StaffLoginResponse {
  StaffLoginResponse({
      String? msg, 
      String? status, 
      Data? data,}){
    _msg = msg;
    _status = status;
    _data = data;
}

  StaffLoginResponse.fromJson(dynamic json) {
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

/// id : "2"
/// name : "Hritvi"
/// phone : "9586033791"
/// password : "81dc9bdb52d04dc20036dbd8313ed055"
/// code : "TN62C2CE1EC110A"
/// roleid : "2"
/// is_delete : "0"

class Data {
  Data({
      String? id, 
      String? name, 
      String? phone, 
      String? password, 
      String? code, 
      String? roleid, 
      String? isDelete,}){
    _id = id;
    _name = name;
    _phone = phone;
    _password = password;
    _code = code;
    _roleid = roleid;
    _isDelete = isDelete;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _password = json['password'];
    _code = json['code'];
    _roleid = json['roleid'];
    _isDelete = json['is_delete'];
  }
  String? _id;
  String? _name;
  String? _phone;
  String? _password;
  String? _code;
  String? _roleid;
  String? _isDelete;

  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;
  String? get password => _password;
  String? get code => _code;
  String? get roleid => _roleid;
  String? get isDelete => _isDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['password'] = _password;
    map['code'] = _code;
    map['roleid'] = _roleid;
    map['is_delete'] = _isDelete;
    return map;
  }

}