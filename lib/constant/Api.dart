class Api{

  Api._();


  // static  String  endpoint = "https://shraddha.svipldemowork.com/api";
  // static  String  endpoint = "http://shraddha.svipldemoz.com/api";
  static  String  endpoint = "https://www.shraddhaornaments.com/api";
   static  String  register = endpoint+"/register";
   static  String  login = endpoint+"/login";
   static  String  check_security_code = endpoint+"/check_security_code";
   static  String  updateProfile = endpoint+"/updateProfile";
   static  String  updatePassword = endpoint+"/updatePassword";
   static  String  user_detail = endpoint+"/user_detail";
   static  String  forgot_password = endpoint+"/forgot-password";
   static  String  forgot_securitycode = endpoint+"/forgot-securitycode";


   static  String  logout = endpoint+"/logout";
  static  String  deleteAccount = endpoint+"/user-delete";
   static  String  slider = endpoint+"/slider";
   static  String  maincategory = endpoint+"/maincategory";
   static  String  categorytag = endpoint+"/categorytag";
   static  String  new_products = endpoint+"/new-products";
   static  String  bast_product = endpoint+"/bast-product";
   static  String  subcategory = endpoint+"/subcategory";
   static  String  category_products = endpoint+"/sort-by-categoryproducts";
   static  String  category_new_products = endpoint+"/category-products";
   static  String  product_detail = endpoint+"/product-detail";
   static  String  placeorder = endpoint+"/order/store";
  // static  String  order = endpoint+"/order";
  static  String  order = endpoint+"/order-customer";
  static  String  orderDetails = endpoint+"/order-detail";
   static  String  display_wishlist = endpoint+"/display-wishlist";
   static  String  addWishlist = endpoint+"/store-wishlist";
   static  String  removeWhishlist = endpoint+"/remove-wishlist";
   static  String  searchProduct = endpoint+"/search-categoryproducts";
  static  String  searchTermProduct = endpoint+"/search-term-product";
  static  String  termList = endpoint+"/search-term-list";


   static  String  comman = endpoint+"/comman";
   static  String  about_us = endpoint+"/about-us";
   static  String  order_remove = endpoint+"/order-remove";
   static  String  cart_check = endpoint+"/cart";


}