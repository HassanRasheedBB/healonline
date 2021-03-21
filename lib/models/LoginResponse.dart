class LoginResponse {
  String type;
  profile profile_obj;
  String token;
  String is_loggedIn;

  LoginResponse({this.type, this.profile_obj, this.token, this.is_loggedIn});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      type: json['type'] as String,
      token: json['token'] as String,
      profile_obj: profile.fromJson(json["profile"]),
    );
  }
}

class pmeta {
  String user_type;
  String profile_img;
  String gender;
  String full_name;

  pmeta({this.user_type, this.profile_img, this.gender, this.full_name});

  factory pmeta.fromJson(Map<String, dynamic> json) {
    return pmeta(
      user_type: json["user_type"] as String,
      profile_img: json["profile_img"] as String,
      gender: json["_gender"] as String,
      full_name: json["full_name"] as String,
    );
  }
}

class umeta {
  String user_login, user_pass, user_email;
  int profile_id, id;

  umeta(
      {this.profile_id,
      this.id,
      this.user_login,
      this.user_pass,
      this.user_email});

  factory umeta.fromJson(Map<String, dynamic> json) {
    return umeta(
      profile_id: json["profile_id"] as int,
      id: json["id"] as int,
      user_login: json["user_login"] as String,
      user_pass: json["user_pass"] as String,
      user_email: json["user_email"] as String,
    );
  }
}

class profile {
  pmeta pmeta_obj;

  umeta umeta_obj;

  profile({this.pmeta_obj, this.umeta_obj});

  factory profile.fromJson(Map<String, dynamic> json) {
    return profile(
      pmeta_obj: pmeta.fromJson(json["pmeta"]),
      umeta_obj: umeta.fromJson(json["umeta"]),
    );
  }
}
