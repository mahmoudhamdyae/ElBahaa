class SubscriptionResponse {
  int? status;
  List<UserCourses>? courses;

  SubscriptionResponse({this.status, this.courses});

  SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Courses'] != null) {
      courses = <UserCourses>[];
      json['Courses'].forEach((v) {
        courses!.add(UserCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (courses != null) {
      data['Courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCourses {
  int? id;
  String? subjectName;
  int? techerId;
  String? stage;
  String? classroom;
  String? expiryDate;
  String? type;
  dynamic teacherRatioCourse;
  int? termPrice;
  int? monthlySubscriptionPrice;
  String? termType;
  int? active;
  String? createdAt;
  String? updatedAt;
  Techer? techer;

  UserCourses(
      {this.id,
        this.subjectName,
        this.techerId,
        this.stage,
        this.classroom,
        this.expiryDate,
        this.type,
        this.teacherRatioCourse,
        this.termPrice,
        this.monthlySubscriptionPrice,
        this.termType,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.techer});

  UserCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    techerId = json['techer_id'];
    stage = json['stage'];
    classroom = json['classroom'];
    expiryDate = json['expiry_date'];
    type = json['type'];
    teacherRatioCourse = json['Teacher_ratio_course'];
    termPrice = json['term_price'];
    monthlySubscriptionPrice = json['monthly_subscription_price'];
    termType = json['term_type'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    techer =
    json['techer'] != null ? Techer.fromJson(json['techer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['techer_id'] = techerId;
    data['stage'] = stage;
    data['classroom'] = classroom;
    data['expiry_date'] = expiryDate;
    data['type'] = type;
    data['Teacher_ratio_course'] = teacherRatioCourse;
    data['term_price'] = termPrice;
    data['monthly_subscription_price'] = monthlySubscriptionPrice;
    data['term_type'] = termType;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (techer != null) {
      data['techer'] = techer!.toJson();
    }
    return data;
  }
}

class Techer {
  int? id;
  String? name;
  String? image;

  Techer({this.id, this.name, this.image});

  Techer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}