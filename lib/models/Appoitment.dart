class Appointment{
  String province, symptoms, howLongFelt, covidYesNo, covidLocation, covidTimeTravel,
  sickNote, AudioOrVideo, additionalDetails, isImageAttached, doctorPhone, appointmentDate, appointmentTime;
  String docName, docSkills, appointmentFor;
  String userId, docId, userName;

  String age, weight, height, maritalStatus, bloodGroup, history, gender, userEmail;

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
      this.appointmentFor,
      this.userId,
      this.docId,
      this.userName,
      this.age,
      this.weight,
      this.height,
      this.maritalStatus,
      this.bloodGroup,
      this.history,
      this.gender,
      this.userEmail
      );




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
      "appointmentFor":appointmentFor,
      "userName": userName,
      "userId":userId,
      "docId":docId,
      "age": age,
      "weight": weight,
      "height": height,
      "maritalStatus": maritalStatus,
      "bloodGroup": bloodGroup,
      "history": history,
      "gender" : gender,
      "userEmail": userEmail
    };
  }

}