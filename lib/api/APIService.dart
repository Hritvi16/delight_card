import 'dart:convert';
import 'package:delight_card/model/CardVerificationResponse.dart';
import 'package:delight_card/model/PlaceLoginResponse.dart';
import 'package:http/http.dart' as http;
import 'package:delight_card/api/Environment.dart';
import 'package:delight_card/model/AccessListResponse.dart';
import 'package:delight_card/model/AdminLoginResponse.dart';
import 'package:delight_card/model/AreaListResponse.dart';
import 'package:delight_card/model/CardListResponse.dart';
import 'package:delight_card/model/CityListResponse.dart';
import 'package:delight_card/model/CustomerListResponse.dart';
import 'package:delight_card/model/FamilyListResponse.dart';
import 'package:delight_card/model/PlaceListResponse.dart';
import 'package:delight_card/model/Response.dart';
import 'package:delight_card/model/LoginResponse.dart';
import 'package:delight_card/model/RoleListResponse.dart';
import 'package:delight_card/model/StaffListResponse.dart';
import 'package:delight_card/model/StateListResponse.dart';
import 'package:delight_card/model/UserAccessListResponse.dart';
import 'package:delight_card/model/UsersListResponse.dart';
import '../model/PlacesTypeListResponse.dart';
import '../model/StaffLoginResponse.dart';
import 'APIConstant.dart';

class APIService {
  // getHeader() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map<String, String> headers = {
  //     APIConstant.authorization : APIConstant.token+(sharedPreferences.getString("token")??"")+"."+base64Encode(utf8.encode(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))),
  //     "Accept": "application/json",
  //   };
  //   return headers;
  // }

  // getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String token = sharedPreferences.getString("token")??"";
  //   return token;
  // }
  Future<LoginResponse> login(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCustomer);
    print(url);
    var result = await http.post(url, body: data);
    LoginResponse loginResponse = LoginResponse.fromJson(json.decode(result.body));
    return loginResponse;
  }

  Future<StaffLoginResponse> staffLogin(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageStaff);
    print(url);
    var result = await http.post(url, body: data);
    StaffLoginResponse staffLoginResponse = StaffLoginResponse.fromJson(json.decode(result.body));
    return staffLoginResponse;
  }

  Future<AdminLoginResponse> adminLogin(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageUser);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    AdminLoginResponse adminLoginResponse = AdminLoginResponse.fromJson(json.decode(result.body));
    return adminLoginResponse;
  }

  Future<PlaceLoginResponse> placeLogin(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.managePlaces);
    print(url);
    var result = await http.post(url, body: data);
    PlaceLoginResponse placeLoginResponse = PlaceLoginResponse.fromJson(json.decode(result.body));
    return placeLoginResponse;
  }

  Future<Response> signUp(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCustomer);
    print(url);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<PlaceLoginResponse> checkPlaceLogin(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.managePlaces);
    print(url);
    var result = await http.post(url, body: data);
    PlaceLoginResponse placeLoginResponse = PlaceLoginResponse.fromJson(json.decode(result.body));
    return placeLoginResponse;
  }

  Future<Response> auPlaceLogin(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.managePlaces);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<UsersListResponse> getUsers(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageUser, queryParameters);
    print(url);
    var result = await http.get(url);
    UsersListResponse usersListResponse = UsersListResponse.fromJson(json.decode(result.body));
    return usersListResponse;
  }

  Future<Response> addUser(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageUser);
    print(url);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteUser(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageUser, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<StaffListResponse> getStaffs(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageStaff, queryParameters);
    print(url);
    var result = await http.get(url);
    StaffListResponse staffListResponse = StaffListResponse.fromJson(json.decode(result.body));
    return staffListResponse;
  }

  Future<Response> deleteStaff(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageStaff, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> addStaff(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageStaff);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<RoleListResponse> getRoles(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageRoles, queryParameters);
    print(url);
    var result = await http.get(url);
    RoleListResponse roleListResponse = RoleListResponse.fromJson(json.decode(result.body));
    return roleListResponse;
  }

  Future<Response> auRole(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageRoles);
    print(url);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteRole(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageRoles, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<CustomerListResponse> getCustomers(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCustomer, queryParameters);
    print(url);
    var result = await http.get(url);
    CustomerListResponse customerListResponse = CustomerListResponse.fromJson(json.decode(result.body));
    return customerListResponse;
  }


  Future<StateListResponse> getStates(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageStates, queryParameters);
    print(url);
    var result = await http.get(url);
    StateListResponse stateListResponse = StateListResponse.fromJson(json.decode(result.body));
    return stateListResponse;
  }

  Future<Response> auState(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageStates);
    print(url);
    var result = await http.post(url, body: data);
    print(data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteState(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageStates, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<CityListResponse> getCities(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCities, queryParameters);
    print(url);
    var result = await http.get(url);
    CityListResponse cityListResponse = CityListResponse.fromJson(json.decode(result.body));
    return cityListResponse;
  }

  Future<Response> auCity(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCities);
    print(url);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteCity(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCities, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<AreaListResponse> getAreas(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageAreas, queryParameters);
    print(url);
    var result = await http.get(url);
    AreaListResponse areaListResponse = AreaListResponse.fromJson(json.decode(result.body));
    return areaListResponse;
  }

  Future<Response> auArea(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageAreas);
    print(url);
    var result = await http.post(url, body: data);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteArea(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageAreas, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<PlaceListResponse> getPlaces(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePlaces, queryParameters);
    print(url);
    var result = await http.get(url);
    PlaceListResponse placeListResponse = PlaceListResponse.fromJson(json.decode(result.body));
    return placeListResponse;
  }

  Future<Response> auPlace(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.managePlaces);
    print(url);
    print("hello url");
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> auPlaceF(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.managePlaces);
    print(url);
    var request = await http.MultipartRequest(
          'POST', url);
      request.files.add(
          await http.MultipartFile.fromPath(
              'places',
              data['places']
          )
      );
      request.fields['act'] = data['act'];
      request.fields['name'] = data['name'];
      request.fields['start_time'] = data['start_time'];
      request.fields['end_time'] = data['end_time'];
      request.fields['mobile'] = data['mobile'];
      request.fields['lat'] = data['lat'];
      request.fields['longi'] = data['longi'];
      request.fields['address'] = data['address'];
      request.fields['description'] = data['description'];
      request.fields['tc'] = data['tc'];
      request.fields['ar_id'] = data['ar_id'];
      request.fields['pt_id'] = data['pt_id'];
      if(data['act']==APIConstant.update)
        request.fields['id'] = data['id'];

      print("request.fields");
      print(request.fields);

      var res = await request.send();
      print(res.reasonPhrase);
      //Convert Stream to String
      final respStr = await res.stream.bytesToString();
      print(respStr);
      //Convert String to Json and Json to Object
      Response response = Response.fromJson(jsonDecode(respStr));
      return response;
  }

  Future<PlaceResponse> getPlaceDetails(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePlaces, queryParameters);
    print(url);
    var result = await http.get(url);
    PlaceResponse placeResponse = PlaceResponse.fromJson(json.decode(result.body));
    return placeResponse;
  }

  Future<Response> deletePlace(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePlaces, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<AccessListResponse> getAccess(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageAccess, queryParameters);
    print(url);
    var result = await http.get(url);
    AccessListResponse accessListResponse = AccessListResponse.fromJson(json.decode(result.body));
    return accessListResponse;
  }

  Future<UserAccessListResponse> getUserAccess(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageUserAccess, queryParameters);
    print(url);
    var result = await http.get(url);
    UserAccessListResponse userAccessListResponse = UserAccessListResponse.fromJson(json.decode(result.body));
    return userAccessListResponse;
  }

  Future<Response> manageUserAccess(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageUserAccess);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<CardListResponse> getCards(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCards, queryParameters);
    print(url);
    var result = await http.get(url);
    print(result.body);
    CardListResponse cardListResponse = CardListResponse.fromJson(json.decode(result.body));
    return cardListResponse;
  }

  Future<CardVerificationResponse> verifyCard(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCards);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    CardVerificationResponse cardVerificationResponse = CardVerificationResponse.fromJson(json.decode(result.body));
    return cardVerificationResponse;
  }

  Future<CardResponse> getCard(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCards, queryParameters);
    print(url);
    var result = await http.get(url);
    CardResponse cardResponse = CardResponse.fromJson(json.decode(result.body));
    return cardResponse;
  }

  Future<ApplyCardResponse> addCard(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageCards);
    print(url);
    var result = await http.post(url, body: data);
    ApplyCardResponse applyCardResponse = ApplyCardResponse.fromJson(json.decode(result.body));
    return applyCardResponse;
  }

  Future<PlacesTypeListResponse> getPlacesType(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.managePlacesType, queryParameters);
    print(url);
    var result = await http.get(url);
    PlacesTypeListResponse placesTypeListResponse = PlacesTypeListResponse.fromJson(json.decode(result.body));
    return placesTypeListResponse;
  }

  Future<FamilyListResponse> getFamilies(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageFamily, queryParameters);
    print(url);
    var result = await http.get(url);
    FamilyListResponse familyListResponse = FamilyListResponse.fromJson(json.decode(result.body));
    return familyListResponse;
  }

  Future<Response> addFamily(Map<String, dynamic> data) async{
    var url = Uri.parse(Environment.url1 + Environment.api1 +APIConstant.manageFamily);
    print(url);
    var result = await http.post(url, body: data);
    print(result.body);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }

  Future<Response> deleteFamily(Map<String, dynamic> queryParameters) async{
    var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageFamily, queryParameters);
    print(url);
    var result = await http.get(url);
    Response response = Response.fromJson(json.decode(result.body));
    return response;
  }
// Future<CityResponse> getCitiesByName(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.parse(APIConstant.manageCities);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   CityResponse cityResponse = CityResponse.fromJson(json.decode(result.body));
  //   return cityResponse;
  // }
  //
  // Future<PopularCityResponse> getPopularCities(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageCities, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   PopularCityResponse popularCityResponse = PopularCityResponse.fromJson(json.decode(result.body));
  //   return popularCityResponse;
  // }
  //
  // Future<BannerResponse> getBanners() async{
  //   var url = Uri.parse(APIConstant.getBanners);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   BannerResponse bannerResponse = BannerResponse.fromJson(json.decode(result.body));
  //   return bannerResponse;
  // }
  //
  // Future<HOResponse> getHeadOffices() async{
  //   var url = Uri.parse(APIConstant.getHeadOffices);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HOResponse hoResponse = HOResponse.fromJson(json.decode(result.body));
  //   return hoResponse;
  // }
  //
  // Future<PopBannerResponse> getPopBanner() async{
  //   var url = Uri.parse(APIConstant.getPopBanner);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   PopBannerResponse popBannerResponse = PopBannerResponse.fromJson(json.decode(result.body));
  //   return popBannerResponse;
  // }
  //
  // Future<HotelResponse> getBannerHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<DashboardResponse> getDashboard() async{
  //   var url = Uri.parse(APIConstant.manageDashboard);
  //   Map<String, String> headers = await getHeader();
  //   // String token = await getToken();
  //   // print("token");
  //   var result = await http.get(url, headers: headers);
  //   DashboardResponse dashboardResponse = DashboardResponse.fromJson(json.decode(result.body));
  //   print(dashboardResponse.toJson());
  //   return dashboardResponse;
  // }
  //
  // Future<HotelResponse> getDashboardHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<HotelResponse> getNearbyHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<HotelDetailResponse> getHotelDetails(Map<String, dynamic> queryParameters) async{
  //
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   print("queryParameterssss");
  //   Map<String, String> headers = await getHeader();
  //   print("queryParameterggeesdds");
  //   print(url);
  //   var result = await http.get(url, headers: headers);
  //   print("result.body");
  //   print(result.body);
  //   HotelDetailResponse hotelDetailResponse = HotelDetailResponse.fromJson(json.decode(result.body));
  //   return hotelDetailResponse;
  // }
  //
  // Future<HotelImagesResponse> getHotelImages(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 +APIConstant.getHotelImages, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelImagesResponse hotelImagesResponse = HotelImagesResponse.fromJson(json.decode(result.body));
  //   return hotelImagesResponse;
  // }
  //
  //

  //
  // Future<HotelSlotsResponse> getHotelSlots(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2,APIConstant.getHotelSlots, queryParameters);
  //   print(url);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelSlotsResponse hotelSlotsResponse = HotelSlotsResponse.fromJson(json.decode(result.body));
  //   return hotelSlotsResponse;
  // }
  //
  // Future<CategoryResponse> getCategories(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.getCategories);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   CategoryResponse categoryResponse = CategoryResponse.fromJson(json.decode(result.body));
  //   return categoryResponse;
  // }
  //
  // Future<AmenityResponse> getAmenities(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.getAmenities);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   AmenityResponse amenityResponse = AmenityResponse.fromJson(json.decode(result.body));
  //   return amenityResponse;
  // }
  //
  // Future<HotelTimingsResponse>  getHotelTimings(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.manageHotelTimings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   HotelTimingsResponse hotelTimingsResponse = HotelTimingsResponse.fromJson(json.decode(result.body));
  //   return hotelTimingsResponse;
  // }
  //
  // Future<HotelTimingsResponse> checkAvailability(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.manageHotelTimings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   print(result.body);
  //   HotelTimingsResponse hotelTimingsResponse = HotelTimingsResponse.fromJson(json.decode(result.body));
  //   return hotelTimingsResponse;
  // }
  //
  // Future<NearbyResponse> getNearbyPlaces(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.getNearbyPlaces, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   NearbyResponse nearbyResponse = NearbyResponse.fromJson(json.decode(result.body));
  //   return nearbyResponse;
  // }
  //
  // Future<SpecialRequestResponse> getSpecialRequests() async{
  //   var url = Uri.parse(APIConstant.getSpecialRequests);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   SpecialRequestResponse specialRequestResponse = SpecialRequestResponse.fromJson(json.decode(result.body));
  //   return specialRequestResponse;
  // }
  //
  // Future<HotelOfferResponse> getHotelOffers(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1+Environment.api1+APIConstant.manageOffers);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   HotelOfferResponse hotelOfferResponse = HotelOfferResponse.fromJson(json.decode(result.body));
  //   return hotelOfferResponse;
  // }
  //
  // Future<HotelOfferResponse> getAllOffers(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2+APIConstant.manageOffers, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelOfferResponse hotelOfferResponse = HotelOfferResponse.fromJson(json.decode(result.body));
  //   return hotelOfferResponse;
  // }
  //
  // Future<OfferDetailResponse> getOfferDetails(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1+Environment.api1+APIConstant.manageOffers);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   OfferDetailResponse offerDetailResponse = OfferDetailResponse.fromJson(json.decode(result.body));
  //   return offerDetailResponse;
  // }
  //
  // Future<ConfirmBookingResponse> insertBooking(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageBookings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   ConfirmBookingResponse confirmBookingResponse = ConfirmBookingResponse.fromJson(json.decode(result.body));
  //   return confirmBookingResponse;
  // }
  //
  //
  // Future<BookingResponse> getMyBookings(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageBookings, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   BookingResponse bookingResponse = BookingResponse.fromJson(json.decode(result.body));
  //   return bookingResponse;
  // }
  //
  // Future<BookingDetailResponse> getBookingDetails(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageBookings, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   BookingDetailResponse bookingDetailResponse = BookingDetailResponse.fromJson(json.decode(result.body));
  //   return bookingDetailResponse;
  // }
  //
  // Future<HotelResponse> getWishlistHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageWishlist, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<PolicyResponse> getPolicy(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.managePolicies, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   PolicyResponse policyResponse = PolicyResponse.fromJson(json.decode(result.body));
  //   return policyResponse;
  // }
  //
  // Future<RequestTypeResponse> getRequestTypes(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.getRequestTypes, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   RequestTypeResponse requestTypeResponse = RequestTypeResponse.fromJson(json.decode(result.body));
  //   return requestTypeResponse;
  // }
  //
  // Future<TicketResponse> getRequestedTickets(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, Environment.api2 + APIConstant.manageTickets, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   TicketResponse ticketResponse = TicketResponse.fromJson(json.decode(result.body));
  //   return ticketResponse;
  // }
  //
  // Future<R.Response> raiseTicket(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageTickets);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
  //
  // Future<SearchResponse> search(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.manageSearch);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   SearchResponse searchResponse = SearchResponse.fromJson(json.decode(result.body));
  //   return searchResponse;
  // }
  //
  // Future<CitySearchResponse> citySearch(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.manageSearch);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   CitySearchResponse citySearchResponse = CitySearchResponse.fromJson(json.decode(result.body));
  //   return citySearchResponse;
  // }
  //
  // Future<HotelResponse> getSearchedHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<HotelResponse> getFilteredHotels(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageHotels, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HotelResponse hotelResponse = HotelResponse.fromJson(json.decode(result.body));
  //   return hotelResponse;
  // }
  //
  // Future<HelplineResponse> getOlrHelplines() async{
  //   var url = Uri.parse(APIConstant.getOlrHelplines);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HelplineResponse helplineResponse = HelplineResponse.fromJson(json.decode(result.body));
  //   return helplineResponse;
  // }
  //
  // Future<HelpResponse> getOlrHelps() async{
  //   var url = Uri.parse(APIConstant.getOlrHelps);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   HelpResponse helpResponse = HelpResponse.fromJson(json.decode(result.body));
  //   return helpResponse;
  // }
  //
  // Future<ReviewsResponse> getRatings(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2 ,Environment.api2 + APIConstant.manageReviews, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   ReviewsResponse reviewsResponse = ReviewsResponse.fromJson(json.decode(result.body));
  //   return reviewsResponse;
  // }
  //
  // Future<R.Response> becomePartner(Map<String, dynamic> data) async{
  //   var url = Uri.parse(APIConstant.becomePartner);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
  //
  // Future<AreaResponse> getAreasByName(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageAreas, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   AreaResponse areaResponse = AreaResponse.fromJson(json.decode(result.body));
  //   return areaResponse;
  // }
  //
  // Future<AreaResponse> getAreasByCity(Map<String, dynamic> queryParameters) async{
  //   var url = Uri.http(Environment.url2, APIConstant.manageAreas, queryParameters);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   AreaResponse areaResponse = AreaResponse.fromJson(json.decode(result.body));
  //   return areaResponse;
  // }
  //
  // Future<AmenitiesResponse> getAllAmenities() async{
  //   var url = Uri.parse(APIConstant.getAmenities);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   AmenitiesResponse amenitiesResponse = AmenitiesResponse.fromJson(json.decode(result.body));
  //   return amenitiesResponse;
  // }
  //
  // Future<CancellationReasonResponse> getCancellationReasons() async{
  //   var url = Uri.parse(APIConstant.getCancellationReasons);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.get(url, headers: headers);
  //   CancellationReasonResponse cancellationReasonResponse = CancellationReasonResponse.fromJson(json.decode(result.body));
  //   return cancellationReasonResponse;
  // }
  //
  // Future<R.Response> cancelBooking(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageBookings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
  //
  // Future<R.Response> deleteBooking(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageBookings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   print(result.body);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
  //
  // Future<R.Response> modifyGuestName(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageBookings);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
  //
  // Future<R.Response> giveRatings(Map<String, dynamic> data) async{
  //   var url = Uri.parse(Environment.url1 + Environment.api1 + APIConstant.manageReviews);
  //   Map<String, String> headers = await getHeader();
  //   var result = await http.post(url, body: jsonEncode(data), headers: headers);
  //   R.Response response = R.Response.fromJson(json.decode(result.body));
  //   return response;
  // }
}
