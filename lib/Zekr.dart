class Zekr {
  int id;
  String title;

  Zekr({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
