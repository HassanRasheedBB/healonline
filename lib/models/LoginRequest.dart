class LoginRequest{
  String email;
  String password;
  String device_token;

  LoginRequest(this.email, this.password, this.device_token);

  Map toJson() => {
    'email': email,
    'password': password,
    'device_token':device_token
  };
}