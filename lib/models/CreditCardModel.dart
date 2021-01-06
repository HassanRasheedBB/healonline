class CreditCard{
  String card_number, card_holder_name, card_expiry, card_code;

  CreditCard(this.card_number, this.card_holder_name, this.card_expiry,
      this.card_code);
  toJson() {
    return {
      "card_number": card_number,
      "card_holder_name": card_holder_name,
      "card_expiry": card_expiry,
      "card_code": card_code,
    };
  }
}