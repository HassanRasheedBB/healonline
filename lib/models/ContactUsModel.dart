class ContactUs{
  String email;
  String message;
  String rating;

  ContactUs({this.message, this.email});

  toJson() {
    if(rating != null){
      return {
        "mobile": email,
        "message": message,
        "rating": rating,
      };
    }else {
      return {
        "mobile": email,
        "message": message,
      };
    }
  }

}