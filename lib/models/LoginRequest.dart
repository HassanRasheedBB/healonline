class LoginRequest{
  String email;
  String password;

  LoginRequest(this.email, this.password);

  Map toJson() => {
    'email': email,
    'password': password,
  };
}