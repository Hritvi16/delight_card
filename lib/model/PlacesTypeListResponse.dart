/// placesType : [{"id":"1","name":"Hotel","icon":"hotel.png","is_place":"1"},{"id":"2","name":"Gym","icon":"gym.png","is_place":"1"},{"id":"3","name":"Villa","icon":"villa.png","is_place":"1"},{"id":"8","name":"Terms & Condition","icon":"tc.png","is_place":"0"},{"id":"9","name":"Customer Care","icon":"staff.png","is_place":"0"}]

class PlacesTypeListResponse {
  PlacesTypeListResponse({
      List<PlacesType>? placesType,}){
    _placesType = placesType;
}

  PlacesTypeListResponse.fromJson(dynamic json) {
    if (json['placesType'] != null) {
      _placesType = [];
      json['placesType'].forEach((v) {
        _placesType?.add(PlacesType.fromJson(v));
      });
    }
  }
  List<PlacesType>? _placesType;

  List<PlacesType>? get placesType => _placesType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_placesType != null) {
      map['placesType'] = _placesType?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Hotel"
/// icon : "hotel.png"
/// is_place : "1"

class PlacesType {
  PlacesType({
      String? id, 
      String? name, 
      String? icon, 
      String? isPlace,}){
    _id = id;
    _name = name;
    _icon = icon;
    _isPlace = isPlace;
}

  PlacesType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _isPlace = json['is_place'];
  }
  String? _id;
  String? _name;
  String? _icon;
  String? _isPlace;

  String? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get isPlace => _isPlace;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['is_place'] = _isPlace;
    return map;
  }

}