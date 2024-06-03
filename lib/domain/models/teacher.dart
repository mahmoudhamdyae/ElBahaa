class TeacherResponse {
  List<Teacher>? teacher;

  TeacherResponse({this.teacher});

  TeacherResponse.fromJson(Map<String, dynamic> json) {
    if (json['teacher'] != null) {
      teacher = <Teacher>[];
      json['teacher'].forEach((v) {
        teacher!.add(Teacher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teacher != null) {
      data['teacher'] = teacher!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? name;
  String? image;
  String? teacherDescription;

  Teacher({this.id, this.name, this.image, this.teacherDescription});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    teacherDescription = json['teacher_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['teacher_description'] = teacherDescription;
    return data;
  }
}