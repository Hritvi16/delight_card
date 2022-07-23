/// states : [{"id":"1","name":"Gujarat"},{"id":"2","name":"Maharashtra"},{"id":"3","name":"Rajasthan"}]

class StateListResponse {
  StateListResponse({
      List<States>? states,}){
    _states = states;
}

  StateListResponse.fromJson(dynamic json) {
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
  }
  List<States>? _states;

  List<States>? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Gujarat"

class States {
  States({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  States.fromJson(dynamic json) {
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