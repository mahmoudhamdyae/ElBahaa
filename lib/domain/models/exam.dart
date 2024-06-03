class Exam {
  int? status;
  List<Exams>? exams;
  List<Bank>? bank;

  Exam({this.status, this.exams, this.bank});

  Exam.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(Exams.fromJson(v));
      });
    }
    if (json['bank'] != null) {
      bank = <Bank>[];
      json['bank'].forEach((v) {
        bank!.add(Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (exams != null) {
      data['exams'] = exams!.map((v) => v.toJson()).toList();
    }
    if (bank != null) {
      data['bank'] = bank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  int? id;
  int? teacherId;
  int? courseId;
  dynamic previousTest;
  dynamic solvedTest;
  String? unsolvedTest;
  String? shortOne;
  String? shortTwo;
  String? finalReview;
  String? termType;
  String? createdAt;
  String? updatedAt;

  Exams(
      {this.id,
        this.teacherId,
        this.courseId,
        this.previousTest,
        this.solvedTest,
        this.unsolvedTest,
        this.shortOne,
        this.shortTwo,
        this.finalReview,
        this.termType,
        this.createdAt,
        this.updatedAt});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    previousTest = json['previous_test'];
    solvedTest = json['solved_test'];
    unsolvedTest = json['unsolved_test'];
    shortOne = json['short_one'];
    shortTwo = json['short_two'];
    finalReview = json['final_review'];
    termType = json['term_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['course_id'] = courseId;
    data['previous_test'] = previousTest;
    data['solved_test'] = solvedTest;
    data['unsolved_test'] = unsolvedTest;
    data['short_one'] = shortOne;
    data['short_two'] = shortTwo;
    data['final_review'] = finalReview;
    data['term_type'] = termType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Bank {
  int? id;
  int? teacherId;
  int? courseId;
  String? solvedBank;
  String? unsolvedBank;
  String? bookTest;
  String? termType;
  String? createdAt;
  String? updatedAt;

  Bank({
    this.id,
    this.teacherId,
    this.courseId,
    this.solvedBank,
    this.unsolvedBank,
    this.bookTest,
    this.termType,
    this.createdAt,
    this.updatedAt
  });

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    solvedBank = json['solved_bank'];
    unsolvedBank = json['unsolved_bank'];
    bookTest = json['book_test'];
    termType = json['term_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['course_id'] = courseId;
    data['solved_bank'] = solvedBank;
    data['unsolved_bank'] = unsolvedBank;
    data['book_test'] = bookTest;
    data['term_type'] = termType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}