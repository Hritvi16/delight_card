/// roles : [{"id":"1","name":"Agent"}]

class RoleListResponse {
  RoleListResponse({
      List<Roles>? roles,}){
    _roles = roles;
}

  RoleListResponse.fromJson(dynamic json) {
    if (json['roles'] != null) {
      _roles = [];
      json['roles'].forEach((v) {
        _roles?.add(Roles.fromJson(v));
      });
    }
  }
  List<Roles>? _roles;

  List<Roles>? get roles => _roles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_roles != null) {
      map['roles'] = _roles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Agent"

class Roles {
  Roles({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Roles.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}