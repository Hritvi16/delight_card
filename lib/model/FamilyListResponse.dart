/// families : [{"ID":"1","CUS_ID":"1","NAME":"Kundan","NUMBER":"7228988032"},{"ID":"2","CUS_ID":"1","NAME":"Jignesh","NUMBER":"8866333908"}]

class FamilyListResponse {
  FamilyListResponse({
      List<Families>? families,}){
    _families = families;
}

  FamilyListResponse.fromJson(dynamic json) {
    if (json['families'] != null) {
      _families = [];
      json['families'].forEach((v) {
        _families?.add(Families.fromJson(v));
      });
    }
  }
  List<Families>? _families;

  List<Families>? get families => _families;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_families != null) {
      map['families'] = _families?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "1"
/// CUS_ID : "1"
/// NAME : "Kundan"
/// NUMBER : "7228988032"

class Families {
  Families({
      String? id, 
      String? cusid, 
      String? name, 
      String? number,}){
    _id = id;
    _cusid = cusid;
    _name = name;
    _number = number;
}

  Families.fromJson(dynamic json) {
    _id = json['ID'];
    _cusid = json['CUS_ID'];
    _name = json['NAME'];
    _number = json['NUMBER'];
  }
  String? _id;
  String? _cusid;
  String? _name;
  String? _number;

  String? get id => _id;
  String? get cusid => _cusid;
  String? get name => _name;
  String? get number => _number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['CUS_ID'] = _cusid;
    map['NAME'] = _name;
    map['NUMBER'] = _number;
    return map;
  }

}