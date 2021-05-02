import 'package:HealOnline/Utils.dart';

class Appointment{
  String province, symptoms, howLongFelt, covidYesNo, covidLocation, covidTimeTravel,
  sickNote, AudioOrVideo, additionalDetails, appointmentDate, appointmentTime;
  String appointmentFor;
  String userId, docId, userName;
  String time_standard;

  String docName="";
  String docEmail="";
  String skills="";


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
      this.appointmentDate,
      this.appointmentTime,
      this.appointmentFor,
      this.userId,
      this.docId,
      this.userName,
      );




  toJson() {
    return {
      "doc_id":"5",
      "patient_id":"10",
      "province": province,
      "symptoms": symptoms,
      "how_long_felt": howLongFelt,
      "covid": "0",
      "covid_location": covidLocation,
      "covid_time_travel": covidTimeTravel,
      "sick_note": sickNote,
      "appointment_files":"1",
      "file_data[0][type]":"image",
      "file_data[0][file]": AudioOrVideo,
      "additional_details": additionalDetails,
      "date": "2021-03-02",
      "time": "05:26",
      "appointment_for":appointmentFor,
      "userName": userName,
      "userId":userId,
      "docId":docId,
      "status":"0"
    };
  }

}