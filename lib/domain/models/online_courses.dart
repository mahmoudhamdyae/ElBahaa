class OnlineCoursesResponse {
  String? status;
  List<OnlineCourses>? courses;

  OnlineCoursesResponse({this.status, this.courses});

  OnlineCoursesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['courses'] != null) {
      courses = <OnlineCourses>[];
      json['courses'].forEach((v) {
        courses!.add(OnlineCourses.fromJson(v));
      });
    }
  }
}

class OnlineCourses {
  int? id;
  String? userId;
  String? date;
  String? time;
  String? minute;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  OnlineCourses(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.minute,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  OnlineCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    minute = json['minute'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}