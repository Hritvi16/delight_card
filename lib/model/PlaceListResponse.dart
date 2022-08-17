/// places : [{"id":"1","pt_id":"1","name":"Spice Petals","image":"images/1.jpg","start_time":"11:00:00","end_time":"21:00:00","mobile":"9864773883","lat":"78.83993","longi":"78.38939","address":"102/103/104 Western Vesu Point, opp. Vijyalaxmi hall, Vesu, Surat, Gujarat 395007","description":"Exclusive dining area with superb food.","ar_id":"2","is_delete":"0","ar_name":"Sama","place_type":"Hotel"},{"id":"2","pt_id":"2","name":"Gymkhana","image":"images/1.jpg","start_time":"12:00:00","end_time":"22:00:00","mobile":"9864703883","lat":"78.83993","longi":"78.38939","address":"Piplod, Near Radiant School. Surat.","description":"Best gym with superb equipments","ar_id":"14","is_delete":"0","ar_name":"Manjalpur ","place_type":"Gym"},{"id":"3","pt_id":"3","name":"Froyoland","image":"images/1.jpg","start_time":"11:00:00","end_time":"23:00:00","mobile":"9864773083","lat":"78.83993","longi":"78.38939","address":"Shop No. 25, Prime Shoppers Udaana, Udhana - Magdalla Rd, Vesu, Rundh, Gujarat 395007","description":"Make your ice cream with your favourite toppings.","ar_id":"2","is_delete":"0","ar_name":"Sama","place_type":"Villa"},{"id":"4","pt_id":"1","name":"Aryan Restaurant","image":"images/logo.jpg","start_time":"10:00:00","end_time":"23:00:00","mobile":"","lat":"0","longi":"0","address":"86, Jaitun Nagar,\r\nOpp Santop SoC,\r\nNr Fatehgunj Police Station,\r\nOld chhani Road,\r\nNavayard, Vadodara -390002","description":"Non Veg \r\n\r\n10 % off on final billing","ar_id":"48","is_delete":"0","ar_name":"Navayard","place_type":"Hotel"},{"id":"5","pt_id":"1","name":"Maruti Restaurant","image":"images/logo.jpg","start_time":"10:00:00","end_time":"23:00:00","mobile":"","lat":"0","longi":"0","address":"A-4 Nand Complex Ajanta Sociecty B/H Trident Complex,Ellora Park,Vadodara-390007","description":"15% Discount on Ala Carte Menu -365 Days\r\n\r\nOn occasion of Birthday and Anniversary-25 % Discount\r\n\r\nBanquet Hall Booking:20% Discount","ar_id":"47","is_delete":"0","ar_name":"Ellora Park","place_type":"Hotel"},{"id":"6","pt_id":"1","name":"hegs","image":"images/1658125295-scaled_image_picker4529743037383117304.jpg","start_time":"10:00:00","end_time":"11:00:00","mobile":"7228988032","lat":"23.21","longi":"22.64","address":"address","description":"offer","ar_id":"2","is_delete":"0","ar_name":"Sama","place_type":"Hotel"}]

class PlaceListResponse {
  PlaceListResponse({
      List<Places>? places,}){
    _places = places;
}

  PlaceListResponse.fromJson(dynamic json) {
    if (json['places'] != null) {
      _places = [];
      json['places'].forEach((v) {
        _places?.add(Places.fromJson(v));
      });
    }
  }
  List<Places>? _places;

  List<Places>? get places => _places;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_places != null) {
      map['places'] = _places?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PlaceResponse {
  PlaceResponse({
      Places? places,}){
    _places = places;
}

  PlaceResponse.fromJson(dynamic json) {
    _places = json['places'] != null ? Places.fromJson(json['places']) : Places();
  }
  Places? _places;

  Places? get places => _places;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['places'] = _places?.toJson();
    return map;
  }

}

/// id : "1"
/// pt_id : "1"
/// name : "Spice Petals"
/// image : "images/1.jpg"
/// start_time : "11:00:00"
/// end_time : "21:00:00"
/// mobile : "9864773883"
/// lat : "78.83993"
/// longi : "78.38939"
/// address : "102/103/104 Western Vesu Point, opp. Vijyalaxmi hall, Vesu, Surat, Gujarat 395007"
/// description : "Exclusive dining area with superb food."
/// ar_id : "2"
/// is_delete : "0"
/// ar_name : "Sama"
/// place_type : "Hotel"

class Places {
  Places({
      String? id, 
      String? ptId, 
      String? name, 
      String? image, 
      String? startTime, 
      String? endTime, 
      String? mobile, 
      String? lat, 
      String? longi, 
      String? address, 
      String? description, 
      String? speciality,
      String? tc,
      String? arId,
      String? isDelete, 
      String? isVeg,
      String? arName,
      String? placeType,}){
    _id = id;
    _ptId = ptId;
    _name = name;
    _image = image;
    _startTime = startTime;
    _endTime = endTime;
    _mobile = mobile;
    _lat = lat;
    _longi = longi;
    _address = address;
    _description = description;
    _speciality = speciality;
    _tc = tc;
    _arId = arId;
    _isDelete = isDelete;
    _isVeg = isVeg;
    _arName = arName;
    _placeType = placeType;
}

  Places.fromJson(dynamic json) {
    _id = json['id'];
    _ptId = json['pt_id'];
    _name = json['name'];
    _image = json['image'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _mobile = json['mobile'];
    _lat = json['lat'];
    _longi = json['longi'];
    _address = json['address'];
    _description = json['description'];
    _speciality = json['speciality'];
    _tc = json['tc'];
    _arId = json['ar_id'];
    _isDelete = json['is_delete'];
    _isVeg = json['is_veg'];
    _arName = json['ar_name'];
    _placeType = json['place_type'];
  }
  String? _id;
  String? _ptId;
  String? _name;
  String? _image;
  String? _startTime;
  String? _endTime;
  String? _mobile;
  String? _lat;
  String? _longi;
  String? _address;
  String? _description;
  String? _speciality;
  String? _tc;
  String? _arId;
  String? _isDelete;
  String? _isVeg;
  String? _arName;
  String? _placeType;

  String? get id => _id;
  String? get ptId => _ptId;
  String? get name => _name;
  String? get image => _image;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get mobile => _mobile;
  String? get lat => _lat;
  String? get longi => _longi;
  String? get address => _address;
  String? get description => _description;
  String? get speciality => _speciality;
  String? get tc => _tc;
  String? get arId => _arId;
  String? get isDelete => _isDelete;
  String? get isVeg => _isVeg;
  String? get arName => _arName;
  String? get placeType => _placeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pt_id'] = _ptId;
    map['name'] = _name;
    map['image'] = _image;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['mobile'] = _mobile;
    map['lat'] = _lat;
    map['longi'] = _longi;
    map['address'] = _address;
    map['description'] = _description;
    map['speciality'] = _speciality;
    map['tc'] = _tc;
    map['ar_id'] = _arId;
    map['is_delete'] = _isDelete;
    map['is_veg'] = _isVeg;
    map['ar_name'] = _arName;
    map['place_type'] = _placeType;
    return map;
  }

}