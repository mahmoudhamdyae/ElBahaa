class Lesson {
  int? id;
  String? name;
  String? link;
  String? pdf;
  String? type;
  int? tutorialId;
  String? createdAt;
  String? updatedAt;
  int? order;
  List<Comments>? comments;

  Lesson(
      {this.id,
        this.name,
        this.link,
        this.pdf,
        this.type,
        this.tutorialId,
        this.createdAt,
        this.updatedAt,
        this.order,
        this.comments});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    pdf = json['pdf'];
    type = json['type'];
    tutorialId = json['tutorial_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['pdf'] = pdf;
    data['type'] = type;
    data['tutorial_id'] = tutorialId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order'] = order;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  String? comment;
  int? videoId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
        this.comment,
        this.videoId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    videoId = json['video_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['video_id'] = videoId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}