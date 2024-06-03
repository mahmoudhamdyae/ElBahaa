import 'package:elbahaa/domain/models/courses/course.dart';
import 'package:elbahaa/domain/models/lesson/lesson.dart';

class ReturnedVideo {
  Course course;
  Lesson lesson;

  ReturnedVideo(this.course, this.lesson);
}