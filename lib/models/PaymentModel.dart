class PaymentModel {
  String card_id, amount;

  PaymentModel({
    this.card_id,
    this.amount,
  });

  toJson() {
    return {
      "card_id": card_id,
      "amount": amount,
    };
  }
}
