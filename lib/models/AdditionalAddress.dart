class AdditionalAddress {
  String address1, address2, city_name, zipCode, province;

  AdditionalAddress({this.address1, this.address2, this.city_name, this.zipCode,
      this.province});

  toJson() {
    return {
      "address_1": address1,
      "address_2": address2,
      "city": city_name,
      "zipcode": zipCode,
      "province": province,
    };
  }

  factory AdditionalAddress.fromJson(Map<String, dynamic> json) {
    return AdditionalAddress(
      address1: json["address_1"] as String,
      address2: json["address_2"] as String,
        city_name: json["city"] as String,
        zipCode: json["zipcode"] as String,
        province: json["province"] as String
    );
  }

}
