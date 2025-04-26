import 'package:hive/hive.dart';

part 'Formats.g.dart';

@HiveType(typeId: 2)
class Formats {
  @HiveField(0)
  String? texthtml;

  @HiveField(1)
  String? applicationepubzip;

  @HiveField(2)
  String? applicationxmobipocketebook;

  @HiveField(3)
  String? applicationrdfxml;

  @HiveField(4)
  String? imagejpeg;

  @HiveField(5)
  String? textplaincharsetusascii;

  @HiveField(6)
  String? applicationoctetstream;

  Formats({
    this.texthtml,
    this.applicationepubzip,
    this.applicationxmobipocketebook,
    this.applicationrdfxml,
    this.imagejpeg,
    this.textplaincharsetusascii,
    this.applicationoctetstream,
  });

  Formats.fromJson(dynamic json) {
    texthtml = json['text/html'];
    applicationepubzip = json['application/epub+zip'];
    applicationxmobipocketebook = json['application/x-mobipocket-ebook'];
    applicationrdfxml = json['application/rdf+xml'];
    imagejpeg = json['image/jpeg'];
    textplaincharsetusascii = json['text/plain; charset=us-ascii'];
    applicationoctetstream = json['application/octet-stream'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text/html': texthtml,
      'application/epub+zip': applicationepubzip,
      'application/x-mobipocket-ebook': applicationxmobipocketebook,
      'application/rdf+xml': applicationrdfxml,
      'image/jpeg': imagejpeg,
      'text/plain; charset=us-ascii': textplaincharsetusascii,
      'application/octet-stream': applicationoctetstream,
    };
  }
}
