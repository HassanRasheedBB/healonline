class PasswordChangeModel{
  String current_password, new_password, confirm_password;
  String email;

  PasswordChangeModel({
    this.current_password,
    this.new_password,
    this.confirm_password,
    this.email
  });

  toJson() {
    return {
      "email" : email,
      "password": new_password,
      "current_password": current_password
    };
  }

}