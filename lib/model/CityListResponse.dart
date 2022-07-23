/// cities : [{"id":"1","name":"Surat","s_id":"1"},{"id":"2","name":"Bharuch","s_id":"1"},{"id":"3","name":"Mumbai","s_id":"2"},{"id":"4","name":"Jaipur","s_id":"3"}]

class CityListResponse {
  CityListResponse({
      List<Cities>? cities,}){
    _cities = cities;
}

  CityListResponse.fromJson(dynamic json) {
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? _cities;
CityListResponse copyWith({  List<Cities>? cities,
}) => CityListResponse(  cities: cities ?? _cities,
);
  List<Cities>? get cities => _cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Surat"
/// s_id : "1"

class Cities {
  Cities({
      String? id, 
      String? name, 
      String? sId,
      String? sName,}){
    _id = id;
    _name = name;
    _sId = sId;
    _sName = sName;
}

  Cities.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _sId = json['s_id'];
    _sName = json['s_name'];
  }
  String? _id;
  String? _name;
  String? _sId;
  String? _sName;
Cities copyWith({  String? id,
  String? name,
  String? sId,
}) => Cities(  id: id ?? _id,
  name: name ?? _name,
  sId: sId ?? _sId,
  sName: sName ?? _sName,
);
  String? get id => _id;
  String? get name => _name;
  String? get sId => _sId;
  String? get sName => _sName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['s_id'] = _sId;
    map['s_name'] = _sName;
    return map;
  }

}