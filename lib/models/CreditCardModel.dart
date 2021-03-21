class CreditCard{
  String card_number, card_holder_name, card_expiry, card_code;
  int id ;

  String expiry_month, expiry_year;

  CreditCard({this.card_number, this.card_holder_name, this.expiry_month, this.expiry_year,
      this.card_code});
  toJson() {
    return {
      "number": card_number,
      "name": card_holder_name,
      "expiry_month": expiry_month,
      "expiry_year": expiry_year,
      "code": card_code,
    };
  }

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        card_number: json["number"] as String,
        card_holder_name: json["name"] as String,
      expiry_month: json["expiry_month"] as String,
      expiry_year: json["expiry_year"] as String,
        card_code: json["code"] as String,
    );
  }

}
