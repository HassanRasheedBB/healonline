class PatientModel{
  int id;
  String first_name, last_name, email, gender, dob, mobile, language, pharmacy,
      p_mob_1, p_mob_2, province, health_card_number, insurance_provider, policy_number;

  String bloodGrp, weight, height, maritalStatus;

  PatientModel({
    this.first_name,
    this.last_name,

    this.gender,
    this.dob,
    this.mobile,
    this.language,
    this.pharmacy,
    this.p_mob_1,
    this.p_mob_2,
    this.province,
    this.insurance_provider,
    this.policy_number,
    this.bloodGrp,
    this.maritalStatus,
    this.height,
    this.weight
  });

  toJson() {
    return {
      "first_name": first_name,
      "last_name": last_name,

      "gender": gender,
      "dob" : dob,
      "mobile": mobile,
      "language": language,
      "pharmacy": pharmacy,
      "p_mob_1": p_mob_1,
      "p_mob_2": p_mob_2,
      "province": province,
      "insurance_provider": insurance_provider,
      "policy_number": policy_number,
      "blood_group": bloodGrp,
      "martial_status": maritalStatus,
      "weight": weight,
      "height": height,
    };
  }

}