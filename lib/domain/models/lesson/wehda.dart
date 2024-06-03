import 'package:elbahaa/domain/models/lesson/lesson.dart';

class Wehda {
  String title;
  List<Lesson> lessons;

  Wehda(this.title, this.lessons);

  factory Wehda.fromJson(Map<String, dynamic> json) {
    List<Lesson> lessons = [];
    for (var singleLesson in json["video"]) {
      lessons.add(Lesson.fromJson(singleLesson));
    }
    return Wehda(
      json['name'] as String? ?? '',
      lessons,
    );
  }
}