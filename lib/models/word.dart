
class Word {
  int? id;
  String? city;
  String? country;
  String? details;
  String? flag;

  Word(this.city, this.country);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "city": city,
      "country": country,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }


  Word.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    city = (map["city"] as String?)!;
    country = (map["country"] as String?)!;
  }


  Word.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    country = json["country"];
  }

// static List<Task> myTasks = [
//   Task("task 1", "desc 1", DateTime(1, 1, 1)),
//   Task("task 2", "desc 2", DateTime(1, 1, 1)),
//   Task("task 3", "desc 3", DateTime(1, 1, 1)),
//   Task("task 4", "desc 4", DateTime(1, 1, 1)),
//   Task("task 5", "desc 5", DateTime(1, 1, 1)),
// ];
}