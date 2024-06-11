class Grades {
  List<String>? highSchool;
  List<String>? university;

  Grades({this.highSchool, this.university});

  Grades.fromJson(Map<String, dynamic> json) {
    highSchool = json['high_school'].cast<String>();
    university = json['university'].cast<String>();
  }
}