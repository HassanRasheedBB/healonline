
class RegisterUser{
  String userType,fname, lName, dob, gender, lanuage, email, contact_number,
      password, confirm_password;
  String pharmacy, pharmacyPhone, pharmacyCell, healthCardProvince, helthCardNo,
      insuranceProvider, insurancePolicyNumber;

  String appointmentTimes, appointmentDays, rating, location, skills, patientsCount, appointmentsCount,
  PMDC, experience, reviewerName, reviwerComment, reviewerRating, reviewTimeAgo;

  bool selected = false;


  RegisterUser(
      this.userType,
      this.fname,
      this.lName,
      this.dob,
      this.gender,
      this.lanuage,
      this.email,
      this.contact_number,
      this.password,
      this.confirm_password,
      this.pharmacy,
      this.pharmacyPhone,
      this.pharmacyCell,
      this.healthCardProvince,
      this.helthCardNo,
      this.insuranceProvider,
      this.insurancePolicyNumber,
      this.appointmentTimes,
      this.appointmentDays,
      this.rating,
      this.location,
      this.skills,
      this.patientsCount,
      this.appointmentsCount,
      this.PMDC,
      this.experience,
      this.reviewerName,
      this.reviwerComment,
      this.reviewerRating,
      this.reviewTimeAgo);

  toJson() {
    return {
      "userType": userType,
      "fname": fname,
      "lName": lName,
      "dob": dob,
      "gender": gender,
      "lanuage": lanuage,
      "email": email,
      "contact_number": contact_number,
      "password": password,
      "confirm_password": confirm_password,
      "pharmacy": pharmacy,
      "pharmacyPhone": pharmacyPhone,
      "pharmacyCell": pharmacyCell,
      "healthCardProvince": healthCardProvince,
      "helthCardNo": helthCardNo,
      "insuranceProvider": insuranceProvider,
      "insurancePolicyNumber": insurancePolicyNumber,
      "appointmentTimes": appointmentTimes,
      "appointmentDays": appointmentDays,
      "rating": rating,
      "location": location,
      "skills": skills,
      "patientsCount": patientsCount,
      "appointmentsCount": appointmentsCount,
      "PMDC": PMDC,
      "experience": experience,
      "reviewerName": reviewerName,
      "reviwerComment": reviwerComment,
      "reviewerRating": reviewerRating,
      "reviewTimeAgo": reviewTimeAgo,
    };
  }





}