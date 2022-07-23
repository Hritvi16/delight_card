/// staff : [{"role":"Agent","id":"1","name":"Kundan Yadav Maryad","phone":"7878928817"}]

class StaffListResponse {
  StaffListResponse({
      List<Staff>? staff,}){
    _staff = staff;
}

  StaffListResponse.fromJson(dynamic json) {
    if (json['staff'] != null) {
      _staff = [];
      json['staff'].forEach((v) {
        _staff?.add(Staff.fromJson(v));
      });
    }
  }
  List<Staff>? _staff;

  List<Staff>? get staff => _staff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_staff != null) {
      map['staff'] = _staff?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// role : "Agent"
/// id : "1"
/// name : "Kundan Yadav Maryad"
/// phone : "7878928817"

class Staff {
  Staff({
      String? role, 
      String? id, 
      String? name, 
      String? phone,}){
    _role = role;
    _id = id;
    _name = name;
    _phone = phone;
}

  Staff.fromJson(dynamic json) {
    _role = json['role'];
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
  }
  String? _role;
  String? _id;
  String? _name;
  String? _phone;

  String? get role => _role;
  String? get id => _id;
  String? get name => _name;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = _role;
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }

}