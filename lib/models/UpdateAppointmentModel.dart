class UpdateAppointment{
  String date, time;
  String status;

  UpdateAppointment({
    this.date,
    this.time,
    this.status,
  });

  toJson() {
    return {
      "status" : status,
      "date": date,
      "time": time
    };
  }

}