class ApiConstants {
  static const String baseUrl = "https://e-scheduling.ent-vision.com";
  static const String apiPath = "/api";
  static const String driverPath = "$apiPath/Driver";
  static const String authPath = "$apiPath/auth";
  static const String leavePath = "$apiPath/Leave";
  static const String transportLocationPath = "$apiPath/TransportLocation";

  static const String contentType = "application/json";
  static const String authorizationHeader = "Authorization";
  static const String bearerToken = "Bearer";

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}