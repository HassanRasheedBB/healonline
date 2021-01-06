class AdditionalAddress {
  String address1, address2, city_name, zipCode, province;

  AdditionalAddress(this.address1, this.address2, this.city_name, this.zipCode,
      this.province);

  toJson() {
    return {
      "address1": address1,
      "address2": address2,
      "city_name": city_name,
      "zipCode": zipCode,
      "province": province,
    };
  }
}
