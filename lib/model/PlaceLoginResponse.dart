/// msg : "Success"
/// status : "Login Already Exist"
/// login_data : {"pl_id":"1","p_id":"1","p_username":"spice_petals","p_mobile":"9090909090","p_password":"81dc9bdb52d04dc20036dbd8313ed055","is_delete":"0"}

class PlaceLoginResponse {
  PlaceLoginResponse({
      String? msg, 
      String? status, 
      LoginData? loginData,}){
    _msg = msg;
    _status = status;
    _loginData = loginData;
}

  PlaceLoginResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _loginData = json['login_data'] != null ? LoginData.fromJson(json['login_data']) : null;
  }
  String? _msg;
  String? _status;
  LoginData? _loginData;

  String? get msg => _msg;
  String? get status => _status;
  LoginData? get loginData => _loginData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_loginData != null) {
      map['login_data'] = _loginData?.toJson();
    }
    return map;
  }

}

/// pl_id : "1"
/// p_id : "1"
/// p_username : "spice_petals"
/// p_mobile : "9090909090"
/// p_password : "81dc9bdb52d04dc20036dbd8313ed055"
/// is_delete : "0"

class LoginData {
  LoginData({
      String? plId, 
      String? pId, 
      String? pUsername, 
      String? pMobile, 
      String? pPassword, 
      String? isDelete,}){
    _plId = plId;
    _pId = pId;
    _pUsername = pUsername;
    _pMobile = pMobile;
    _pPassword = pPassword;
    _isDelete = isDelete;
}

  LoginData.fromJson(dynamic json) {
    _plId = json['pl_id'];
    _pId = json['p_id'];
    _pUsername = json['p_username'];
    _pMobile = json['p_mobile'];
    _pPassword = json['p_password'];
    _isDelete = json['is_delete'];
  }
  String? _plId;
  String? _pId;
  String? _pUsername;
  String? _pMobile;
  String? _pPassword;
  String? _isDelete;

  String? get plId => _plId;
  String? get pId => _pId;
  String? get pUsername => _pUsername;
  String? get pMobile => _pMobile;
  String? get pPassword => _pPassword;
  String? get isDelete => _isDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pl_id'] = _plId;
    map['p_id'] = _pId;
    map['p_username'] = _pUsername;
    map['p_mobile'] = _pMobile;
    map['p_password'] = _pPassword;
    map['is_delete'] = _isDelete;
    return map;
  }

}