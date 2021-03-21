import 'dart:convert';

class DoctorModel {
  int id;
  String first_name,
      last_name,
      email,
      gender,
      dob,
      mobile,
      language,
      cpso,
      minc;

  List<Education> education;
  List<Experience> experience;

  DoctorModel({this.first_name,
    this.last_name,
    this.gender,
    this.dob,
    this.mobile,
    this.language,
    this.cpso,
    this.minc});

  toJson() =>
      {
        "first_name": first_name,
        "last_name": last_name,
        "gender": gender,
        "dob": dob,
        "mobile": mobile,
        "language": language,
        "cpso": cpso,
        "minc": minc,
        "education": education,
        "experience": experience,
      };
}

class Education {
  String degree, date, university, location;
  int id;

  Education({this.degree, this.date, this.university, this.location});

  toJson() {
    if (id == null) {
      return {
        "degree": degree,
        "date": date,
        "university": university,
        "location": location
      };
    } else {
      return {
        "id": id,
        "degree": degree,
        "date": date,
        "university": university,
        "location": location
      };
    }
  }
}

class Experience {
  String year, skills;
  int id;

  Experience({this.year, this.skills});

  toJson() {
    if(id == null) {
      return
        {
          "years": year,
          "skills": skills
        };
    }else{
      return
        {
          "id" : id,
          "years": year,
          "skills": skills
        };
    }
  }

}
