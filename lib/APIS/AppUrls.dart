class Feeds {
  static String devUrl = "http://192.168.8.101:4045";
  // auth routes
  static String tenantLogin = "$devUrl/post/login/tenant";
  static String forgotPassword = "$devUrl/post/forgotPassword";
  static String tenantDetails = "$devUrl/specific/specificTenant/";
  static String tenantLastPayment = "$devUrl/get/lastPayment/";
  static String tenantPayments = "$devUrl/get/payments/";
}
