import 'package:elbahaa/domain/models/notes/note.dart';

class Package {
  int? id;
  String? name;
  String? description;
  String? stage;
  String? class1;
  String? price;
  String? expiryDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<Note>? book;

  Package(
      {this.id,
      this.name,
      this.description,
      this.stage,
      this.class1,
      this.price,
      this.expiryDate,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.book});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stage = json['stage'];
    class1 = json['class'];
    price = json['price'];
    expiryDate = json['expiry_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['book'] != null) {
      book = <Note>[];
      json['book'].forEach((v) {
        book!.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['stage'] = stage;
    data['class'] = class1;
    data['price'] = price;
    data['expiry_date'] = expiryDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (book != null) {
      data['book'] = book!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? packageId;
  int? bookId;

  Pivot({this.packageId, this.bookId});

  Pivot.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    bookId = json['book_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['book_id'] = bookId;
    return data;
  }
}
