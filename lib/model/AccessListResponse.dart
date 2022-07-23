/// access : [{"id":"1","name":"City"},{"id":"2","name":"Area"},{"id":"3","name":"Places"}]

class AccessListResponse {
  AccessListResponse({
      List<Access>? access,}){
    _access = access;
}

  AccessListResponse.fromJson(dynamic json) {
    if (json['access'] != null) {
      _access = [];
      json['access'].forEach((v) {
        _access?.add(Access.fromJson(v));
      });
    }
  }
  List<Access>? _access;

  List<Access>? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_access != null) {
      map['access'] = _access?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "City"

class Access {
  Access({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Access.fromJson(dynamic json) {
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