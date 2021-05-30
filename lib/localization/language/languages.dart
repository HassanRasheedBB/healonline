import 'package:flutter/material.dart';

abstract class Languages {


  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get login_as;

  String get patient_string;

  String get health_provider_string;

  String get username;

  String get please_enter_user_name;

  String get password;

  String get please_enter_password;

  String get forgot_password;

  String get login;

  String get dont_have_an_account;

  String get signup;

  String get invalid_credentials;

  String get either_username_or_password_not_correct;

  String get missing_information;

  String get plz_fill_all_fields;

  String get ok;

  String get please_enter_phone_number;

  String get otp_message;

  String get phone_number;

  String get invalid_phone_number;

  String get verfication_code;

  String get type_verification_sent;

  String get resend_code;

  String get error_string;

  String get invalid_code;

  String get success;

  String get signup_as;

  String get enter_first_name;

  String get first_name;

  String get enter_last_name;

  String get last_name;

  String get enter_date_of_birth;

  String get dob_hint;

  String get gender;

  String get male;

  String get female;

  String get other;

  String get enter_language;

  String get language_hint;

  String get enter_email_address;

  String get invalid_email_address;

  String get email_address_hint;

  String get use_strong_password;

  String get password_instructions;

  String get enter_confirm_password;

  String get passwords_dont_match;

  String get confirm_password_hint;

  String get create_account;

  String get already_have_account;

  String get login_here;

  String get search;

  String get select_language;

  String get server_error;

  String get something_went_wrong;

  String get message;

  String get user_registered;

  String get home;

  String get edit_profile;

  String get weight;

  String get height;

  String get blood_grp;

  String get marital_status;

  String get select_province;

  String get province;

  String get pref_parmacy;

  String get select_pharmacy;

  String get insurance;

  String get insurance_provider;

  String get enter_policy_no;

  String get policy_no;

  String get save_string;

  String get profile_updated;

  String get please_wait;

  String get refer_app;

  String get referal_link;

  String get share_with_friends;

  String get or_string;

  String get refer_email;

  String get add_address;

  String get enter_address;

  String get address_1;

  String get address_2;

  String get enter_city;

  String get city_name;

  String get enter_postal_code;

  String get postal_code;

  String get save_address;

  String get address_updated;

  String get add_stripe_card;

  String get enter_card_number;

  String get card_number;

  String get card_holder_name;

  String get card_holder_name_hint;

  String get entry_expiry_date;

  String get expiry;

  String get enter_security_code;

  String get code;

  String get update_card;

  String get expiry_date_err;

  String get card_updated;

  String get health_card;

  String get enter_health_card_no;

  String get health_card_no;

  String get settings;

  String get change_password;

  String get hotline;

  String get faq;

  String get about_us;

  String get contact_us;

  String get password_change;

  String get enter_current_pass;

  String get current_pass;

  String get enter_new_pass;

  String get new_password;

  String get enter_confirm_pass;

  String get confirm_pass;

  String get update_pass;

  String get password_updated;

  String get session_expired;

  String get enter_message;

  String get submit;

  String get query_sent;

  String get appointment_detail;

  String get doc_name;

  String get doc_speciality;

  String get appointment_time;

  String get appointment_date;

  String get symptoms;

  String get sick_note;

  String get additional_details;

  String get appointment_for;

  String get attachments;

  String get questions;

  String get write_sick_note;

  String get need_sick_note;

  String get tell_us_more;

  String get enter_additional_details;

  String get img_physical_symp;

  String get injury;

  String get upload_image;

  String get continue_string;

  String get appointments;

  String get patients;

  String get notifications;

  String get profile;

  String get logout;

  String get call;

  String get cancel;

  String get appointment_presc;

  String get notes;

  String get update_notes;

  String get next_appointment;

  String get select_next_schedual;

  String get require_both_time_and_date;

  String get appointment_updated;

  String get notes_updated;

  String get doc_notes;

  String get experience;

  String get address;

  String get ave_rating;

  String get email;

  String get enter_cpso_number;

  String get cpso_number;

  String get enter_minc_number;

  String get minc_number;

  String get recent_education;

  String get degree;

  String get date;

  String get institution;

  String get prof_experience;

  String get tot_experience;

  String get select_prim_spec;

  String get missing_info;

  String get select_primary_first;

  String get select_speciality;


}
