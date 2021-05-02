
class RegisterUser{

  int roleId;
  int id;
  String userType,fname, lName, dob, gender, lanuage, email, contact_number,
      password, confirm_password, lanuage_abr;

  int patients;
  int appointments;

  String device_token;


  bool selected = false;
  String location="";
  String csnNo="";
  List<String> speciality = [];

  RegisterUser(
      this.roleId,
      this.fname,
      this.lName,
      this.dob,
      this.gender,
      this.lanuage,
      this.email,
      this.contact_number,
      this.password,
      this.confirm_password,
      this.lanuage_abr,
      this.device_token
      );

  toJson() {
    return {
      "role_id": roleId,
      "first_name": fname,
      "last_name": lName,
      "dob": dob,
      "gender": gender,
      "language": lanuage,
      "email": email,
      "mobile": contact_number,
      "password": password,
      "password_confirmation": confirm_password,
      "language_abr": lanuage_abr,
      "device_token":device_token
    };
  }





}