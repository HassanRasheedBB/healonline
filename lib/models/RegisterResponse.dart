

import 'package:HealOnline/models/LoginResponse.dart';

class RegisterReponse{
  String msg,auth;
  int profile_id;
  ErrorMsg err;

  profile profile_obj;

  RegisterReponse({this.msg, this.err, this.profile_id, this.profile_obj});

  factory RegisterReponse.fromJson(Map<String, dynamic> json){

    if(ErrorMsg.fromJson(json["error"]) == null){
      return RegisterReponse(
        msg : json['message'] as String,
        profile_id: json['profile_id'] as int,
        //auth: json['token'] as String,
        profile_obj : profile.fromJson(json["profile"]),
      );
    }else{
      return RegisterReponse(
        msg : json['message'] as String,
        err : ErrorMsg.fromJson(json["error"]),
      );
    }
  }

}

class ErrorMsg{
  String email;

  ErrorMsg({this.email});

  factory ErrorMsg.fromJson(Map<String, dynamic> json){
    if(json == null){
      return null;
    }else {
      return ErrorMsg(
          email: json['email'] as String
      );
    }

  }

}





