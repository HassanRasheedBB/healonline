class UploadItem {
  String title, date, link, type;

  UploadItem(this.title, this.date, this.link, this.type);

  toJson() {
    return {
      "title": title,
      "date": date,
      "link": link,
      "type": type,
    };
  }
}