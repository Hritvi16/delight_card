/// areas : [{"id":"1","name":"Bhagal","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"2","name":"Vesu","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"3","name":"VIP Road","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"4","name":"Salabatpura","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"5","name":"Katargam","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"6","name":"Ghod Dod Road","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"7","name":"Dindoli","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"8","name":"Dabholi","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"9","name":"Athwa","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"10","name":"Parle Point","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"11","name":"Adajan","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"12","name":"Pal","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"13","name":"Varaccha","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"14","name":"Piplod","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"15","name":"Dumas","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"16","name":"Ring Road","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"},{"id":"17","name":"Station","city_id":"1","c_name":"Surat","s_id":"1","s_name":"Gujarat"}]

class AreaListResponse {
  AreaListResponse({
      List<Areas>? areas,}){
    _areas = areas;
}

  AreaListResponse.fromJson(dynamic json) {
    if (json['areas'] != null) {
      _areas = [];
      json['areas'].forEach((v) {
        _areas?.add(Areas.fromJson(v));
      });
    }
  }
  List<Areas>? _areas;

  List<Areas>? get areas => _areas;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_areas != null) {
      map['areas'] = _areas?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Bhagal"
/// city_id : "1"
/// c_name : "Surat"
/// s_id : "1"
/// s_name : "Gujarat"

class Areas {
  Areas({
      String? id, 
      String? name, 
      String? cityId, 
      String? cName, 
      String? sId, 
      String? sName,}){
    _id = id;
    _name = name;
    _cityId = cityId;
    _cName = cName;
    _sId = sId;
    _sName = sName;
}

  Areas.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _cityId = json['city_id'];
    _cName = json['c_name'];
    _sId = json['s_id'];
    _sName = json['s_name'];
  }
  String? _id;
  String? _name;
  String? _cityId;
  String? _cName;
  String? _sId;
  String? _sName;

  String? get id => _id;
  String? get name => _name;
  String? get cityId => _cityId;
  String? get cName => _cName;
  String? get sId => _sId;
  String? get sName => _sName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['city_id'] = _cityId;
    map['c_name'] = _cName;
    map['s_id'] = _sId;
    map['s_name'] = _sName;
    return map;
  }

}