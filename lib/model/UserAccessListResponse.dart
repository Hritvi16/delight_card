/// user_access : [{"id":"2","access":"Area","uid":"1","c":"0","u":"0","r":"0","d":"0"},{"id":"1","access":"City","uid":"2","c":"0","u":"0","r":"0","d":"0"}]

class UserAccessListResponse {
  UserAccessListResponse({
      List<UserAccess>? userAccess,}){
    userAccess = userAccess;
}

  UserAccessListResponse.fromJson(dynamic json) {
    if (json['user_access'] != null) {
      userAccess = [];
      json['user_access'].forEach((v) {
        userAccess?.add(UserAccess.fromJson(v));
      });
    }
  }
  List<UserAccess>? userAccess;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userAccess != null) {
      map['user_access'] = userAccess?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// access : "Area"
/// uid : "1"
/// c : "0"
/// u : "0"
/// r : "0"
/// d : "0"

class UserAccess {
  UserAccess({
      String? id, 
      String? access,
      String? icon,
      String? uid,
      String? c, 
      String? u, 
      String? r, 
      String? d,});

  UserAccess.fromJson(dynamic json) {
    id = json['id'];
    access = json['access'];
    icon = json['icon'];
    uid = json['uid'];
    c = json['c'];
    u = json['u'];
    r = json['r'];
    d = json['d'];
  }
  String? id;
  String? access;
  String? icon;
  String? uid;
  String? c;
  String? u;
  String? r;
  String? d;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['access'] = access;
    map['icon'] = icon;
    map['uid'] = uid;
    map['c'] = c;
    map['u'] = u;
    map['r'] = r;
    map['d'] = d;
    return map;
  }

}