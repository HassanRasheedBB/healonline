import 'package:HealOnline/models/LoginResponse.dart';

class Utils{

  static String baseURL = "http://temp.healonline.ca/public/api/";

  static String USER_LOGIN = "login";
  static String USER_REGISTER = "user-create";
  static String UPDATE_CARD = "card";
  static String UPDATE_ADDRESS = "address";
  static String UPDATE_USER = "user/update";

  static String BOOK_APPOINTMENT = "appointment";

  static String GET_ADDRESS = "addresses/"; ///cards
  static String GET_CARD = "cards/";
  static String GET_USER = "user/edit";

  static String GET_DOCTORS = "get_doctors";
  static String GET_APPOINTMNETS = "appointments";

  static String GET_PATIENTS = "get_patients";

  static String GET_TOKEN = "get_token/";
  static String GET_DOCTOR = "get_doctor/";

  static String SAVE_PRESCRIPTION = "appointment_prescriptions/";
  static String GET_PATIENT_WITH_ID = "get_patient/";

  static String HEALTH_CARD = "health_card";

  static String CARD_PAY = "pay/";

  static String PASSWORD_RESET = "password/update";

  static String QUERY_TO_ADMIN = "query";

  static String UPDATE_APPOINTMENT = "appointment/";

  static String UPDATE_NOTES= "appointment_notes/";


  static Map<String, String> HEADERS = {"Content-type": "application/json"};

  static LoginResponse user;
}