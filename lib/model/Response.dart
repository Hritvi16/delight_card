/// msg : "Success"
/// status : "Customer Added"

class Response {
  Response({
      String? msg, 
      String? status,}){
    _msg = msg;
    _status = status;
}

  Response.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
  }
  String? _msg;
  String? _status;
Response copyWith({  String? msg,
  String? status,
}) => Response(  msg: msg ?? _msg,
  status: status ?? _status,
);
  String? get msg => _msg;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    return map;
  }

}