import 'package:hive/hive.dart';

import 'Authors.dart';
import 'Formats.dart';

part 'Book.g.dart';

@HiveType(typeId: 4)
class Book extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  List<Authors>? authors;

  @HiveField(3)
  List<String>? summaries;

  @HiveField(4)
  List<Authors>? translators;

  @HiveField(5)
  List<String>? subjects;

  @HiveField(6)
  List<String>? bookshelves;

  @HiveField(7)
  List<String>? languages;

  @HiveField(8)
  bool? copyright;

  @HiveField(9)
  String? mediaType;

  @HiveField(10)
  Formats? formats;

  @HiveField(11)
  int? downloadCount;

  Book({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  Book.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    if (json['authors'] != null) {
      authors = [];
      json['authors'].forEach((v) {
        authors?.add(Authors.fromJson(v));
      });
    }
    summaries = json['summaries']?.cast<String>() ?? [];
    if (json['translators'] != null) {
      translators = [];
      json['translators'].forEach((v) {
        translators?.add(Authors.fromJson(v));
      });
    }
    subjects = json['subjects']?.cast<String>() ?? [];
    bookshelves = json['bookshelves']?.cast<String>() ?? [];
    languages = json['languages']?.cast<String>() ?? [];
    copyright = json['copyright'];
    mediaType = json['media_type'];
    formats = json['formats'] != null ? Formats.fromJson(json['formats']) : null;
    downloadCount = json['download_count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (authors != null) {
      map['authors'] = authors?.map((v) => v.toJson()).toList();
    }
    map['summaries'] = summaries;
    if (translators != null) {
      map['translators'] = translators?.map((v) => v.toJson()).toList();
    }
    map['subjects'] = subjects;
    map['bookshelves'] = bookshelves;
    map['languages'] = languages;
    map['copyright'] = copyright;
    map['media_type'] = mediaType;
    if (formats != null) {
      map['formats'] = formats?.toJson();
    }
    map['download_count'] = downloadCount;
    return map;
  }
}
