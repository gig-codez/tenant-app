class Feeds {
  static String devUrl =
      "http://15.237.71.190:4045"; //15.237.71.190   ...192.168.8.101
  // auth routes
  static String tenantLogin = "$devUrl/post/login/tenant";
  static String forgotPassword = "$devUrl/post/forgotPassword";
  static String tenantDetails = "$devUrl/specific/specificTenant/";
  static String tenantLastPayment = "$devUrl/get/lastPayment/";
  static String tenantPayments = "$devUrl/get/payments/";
  static String tenantComplaints = "$devUrl/get/tenantComplaints/";
  static String addComplaint = "$devUrl/post/complaint/create";
}
