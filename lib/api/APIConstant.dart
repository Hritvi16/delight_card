import 'Environment.dart';

class APIConstant {
  static String manageCustomer = "manage-customer.php";
  static String manageUser = "manage-user.php";
  static String manageStaff = "manage-staff.php";
  static String manageStates = "manage-state.php";
  static String manageCities = "manage-city.php";
  static String manageAreas = "manage-area.php";
  static String managePlaces = "manage-places.php";
  static String manageRoles = "manage-roles.php";
  static String manageAccess = "manage-access.php";
  static String manageUserAccess = "manage-user_access.php";
  static String manageCards = "manage-cards.php";
  static String managePlacesType = "manage-place-master.php";
  static String manageFamily = "manage-family.php";

  static String getGSTDetails = "https://gstapi1.charteredinfo.com/commonapi1/v1.1/search";

  static String razorpayApiKey = Environment.url1 + Environment.admin + "razorpay_api1_key.php";
  static String insertUserFCM = Environment.url1 + Environment.api1 + "insertUserFCM.php";
  static String manageDashboard = Environment.url1 + Environment.api1 + "getDashboard.php";
  static String getPopBanner = Environment.url1 + Environment.api1 + "getPopBanner.php";
  static String getBanners = Environment.url1 + Environment.api1 + "getBanners.php";
  static String getHeadOffices = Environment.url1 + Environment.api1 + "getHeadOffices.php";
  static String manageHotels = Environment.api2 + "manage-hotels.php";
  static String manageWishlist = "manage-wishlist.php";
  static String getHotelImages = "getHotelImages.php";
  static String getHotelSlots = Environment.api2 + "getHotelSlots.php";
  static String getCategories = Environment.url1 + Environment.api1 + "getCategories.php";
  static String getAmenities = Environment.url1 + Environment.api1 + "getAmenities.php";
  static String manageHotelTimings = Environment.url1 + Environment.api1 + "manage-hotel-timings.php";
  static String manageOffers = "manage-offers.php";
  static String manageBookings = "manage-bookings.php";
  static String managePolicies = Environment.api2 + "manage-policies.php";
  static String getRequestTypes = Environment.api2 + "getRequestTypes.php";
  static String manageTickets = "manage-tickets.php";
  static String getNearbyPlaces = Environment.api2 + "getNearbyPlaces.php";
  static String getSpecialRequests = Environment.url1 + Environment.api1 + "getSpecialRequests.php";
  static String manageSearch = Environment.url1 + Environment.api1 + "manage-search.php";
  static String getOlrHelplines = Environment.url1 + Environment.api1 + "getOlrHelplines.php";
  static String getOlrHelps = Environment.url1 + Environment.api1 + "getOlrHelps.php";
  static String manageReviews = "manage-reviews.php";
  static String becomePartner = Environment.url1 + Environment.api1 + "becomePartner.php";
  static String getCancellationReasons = Environment.url1 + Environment.api1 + "getCancellationReasons.php";
  // Special Requests Retrieved
  static String act = "act";
  static String type = "type";

  static String getByID = "FETCHBYID";
  static String getByPID = "FETCHBYPID";
  static String getByPAID = "FETCHBYPAID";
  static String getByAID = "FETCHBYAID";
  static String getByBID = "FETCHBYBID";
  static String getByCID = "FETCHBYCID";
  static String getBySID = "FETCHBYSID";
  static String getByName = "FETCHBYNAME";
  static String getPopular = "FETCHPOPULAR";
  static String getByTime = "FETCHBYTIME";
  static String getByHotel = "FETCHBYHOTEL";
  static String getByCategory = "FETCHBYCATEGORY";
  static String getAll = "FETCHALL";
  static String getDashboard = "FETCHDASHBOARD";
  static String getRecommended = "FETCHRECOMMENDED";
  static String getNearby = "FETCHNEARBY";
  static String collection = "COLLECTION";
  static String recommended = "RECOMMENDED";
  static String holiday = "HOLIDAY";
  static String getBySlot = "FETCHBYSLOT";
  static String getByDate = "FETCHBYDATE";
  static String getR = "FETCHR";
  static String getTC = "FETCHTC";
  static String getGP = "FETCHGP";
  static String getPP = "FETCHPP";
  static String getCP = "FETCHCP";
  static String getAU = "FETCHAU";
  static String getHP = "FETCHHP";
  static String auth = "auth";
  static String add = "add";
  static String login = "login";
  static String del = "DEL";
  static String update = "update";
  static String delete = "DEL";
  static String verify = "verify";
  static String search = "SEARCH";
  static String getBySearch = "FETCHBYSEARCH";
  static String getByType = "FETCHBYTYPE";
  static String getByCity = "FETCHBYCITY";
  static String getByCitySearch = "FETCHBYCITYSEARCH";
  static String getByFilter = "FETCHBYFILTER";
  static String getByBanner = "FETCHBYBANNER";

  static String authorization = "Authorization";
  static String token = "Bearer ";

  static String symbol = "₹";
}
