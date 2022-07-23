/// users : [{"role":"Agent","id":"1","name":"Hritvi","email":"hritvi@gmail.com"}]

class UsersListResponse {
  UsersListResponse({
      List<Users>? users,}){
    _users = users;
}

  UsersListResponse.fromJson(dynamic json) {
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
  }
  List<Users>? _users;

  List<Users>? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// role : "Agent"
/// id : "1"
/// name : "Hritvi"
/// email : "hritvi@gmail.com"

class Users {
  Users({
      String? role, 
      String? id, 
      String? name, 
      String? email,}){
    _role = role;
    _id = id;
    _name = name;
    _email = email;
}

  Users.fromJson(dynamic json) {
    _role = json['role'];
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }
  String? _role;
  String? _id;
  String? _name;
  String? _email;

  String? get role => _role;
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = _role;
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    return map;
  }

}