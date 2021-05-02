class AppointmentNotes{
  String notes;
  AppointmentNotes({this.notes});

  toJson() {
    return {
      "notes": notes,
    };
  }
}