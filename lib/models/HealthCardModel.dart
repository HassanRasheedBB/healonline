class HealthCardModel {
  String health_card_province, province, number, dob, sex, phone, address, city, postal_code;
  int id;
  HealthCardModel({
    this.health_card_province,
    this.number,
    this.dob,
    this.sex,
    this.phone,
    this.address,
    this.city,
    this.province,
    this.postal_code
  });

  toJson() {
    return {
      "health_card_province": health_card_province,
      "province": province,
      "number": number,
      "dob": dob,
      "sex": sex,
      "phone": phone,
      "address": address,
      "city": city,
      "postal_code" : postal_code
    };
  }

}
