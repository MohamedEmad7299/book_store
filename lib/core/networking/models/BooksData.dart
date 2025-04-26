

import 'package:hive/hive.dart';

import 'Book.dart';

@HiveType(typeId: 3)
class BooksData extends HiveObject {
  @HiveField(0)
  int? count;

  @HiveField(1)
  String? next;

  @HiveField(2)
  List<Book>? results;

  BooksData({this.count, this.next, this.results});

  BooksData.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'results': results?.map((b) => b.toJson()).toList(),
    };
  }
}
