class Appointment{
  String province, symptoms, howLongFelt, covidYesNo, covidLocation, covidTimeTravel,
  sickNote, AudioOrVideo, additionalDetails, isImageAttached, doctorPhone, appointmentDate, appointmentTime;
  String docName, docSkills, appointmentFor;


  Appointment(
      this.province,
      this.symptoms,
      this.howLongFelt,
      this.covidYesNo,
      this.covidLocation,
      this.covidTimeTravel,
      this.sickNote,
      this.AudioOrVideo,
      this.additionalDetails,
      this.isImageAttached,
      this.doctorPhone,
      this.appointmentDate,
      this.appointmentTime,
      this.docName,
      this.docSkills,
      this.appointmentFor);




  toJson() {
    return {
      "province": province,
      "symptoms": symptoms,
      "howLongFelt": howLongFelt,
      "covidYesNo": covidYesNo,
      "covidLocation": covidLocation,
      "covidTimeTravel": covidTimeTravel,
      "sickNote": sickNote,
      "AudioOrVideo": AudioOrVideo,
      "additionalDetails": additionalDetails,
      "isImageAttached": isImageAttached,
      "doctorPhone": doctorPhone,
      "appointmentDate": appointmentDate,
      "appointmentTime": appointmentTime,
      "docName": docName,
      "docSkills": docSkills,
      "appointmentFor":appointmentFor
    };
  }

}