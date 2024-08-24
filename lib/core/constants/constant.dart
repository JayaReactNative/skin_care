class Constants {
  static String BASE_URL = "https://skin-care-staging-74rki.ondigitalocean.app";
  static String login = "$BASE_URL/v1/auth/login/userLogin";
  static String signup = "$BASE_URL/v1/register/userRegister";
  // https://skin-care-staging-74rki.ondigitalocean.app/v1/product/getAllProduct

  static String forgetpassword =
      "$BASE_URL/v1/auth/login/forgetPasswordSendOtp/";
  static String otpverification = "$BASE_URL/v1/auth/login/forgetVerifyOtp";
  static String changepassword = "$BASE_URL/v1/auth/login/changePassword";
  static String getuserdetail = "$BASE_URL/v1/register/getUserdetail/";
  // all category like cleanser , mosturizer
  static String getallcategory = "$BASE_URL/v1/product/getAllCategory";
  static String getallskin = "$BASE_URL/v1/product/getAllSkinType";
  static String getChatHistory =
      "$BASE_URL/v1/userChat/getAllChat/"; // /v1/userChat/replyOnChat

  static String clearChatHistory = "$BASE_URL/v1/userChat/userChatDelete/";
  static String addChat =
      "$BASE_URL/v1/userChat/replyOnChat/"; // /v1/userChat/replyOnChat
  //   static String update_Profile = "$BASE_URL/v1/product/getAllSkinType";
  // static String update_Profile = "$BASE_URL/v1/product/getAllSkinType";
  static String getallproduct = "$BASE_URL/v1/product/getAllProduct";
  static String favouriteproduct = "$BASE_URL/v1/favourite/favAndUnFavProduct";
  static String getFavouritedata = "$BASE_URL/v1/favourite/getFavDetails/";
  // get all symptoms
  static String getsymptoms = "$BASE_URL/v1/product/getAllSymptom";
  static String getTips = "$BASE_URL/v1/product/getAllSkinBanner";
  static String updateProfile = "$BASE_URL/v1/register/userProfileUpdate";
  static String addImageHistory = "$BASE_URL/v1/register/imageHistory/imageAdd";
  static String getimageHistory = "$BASE_URL/v1/register/imageHistory/";
}



// v1/product/getAllSkinBanner